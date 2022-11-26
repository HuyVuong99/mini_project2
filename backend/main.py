from fastapi import FastAPI

from config_db import db
from models.account import Account
from models.matches import Matches
import schemas.account as schemas_account
import schemas.sign_in
import schemas.matches
import schemas.bets
from models.bets import Bets
from fastapi.middleware.cors import CORSMiddleware
import schemas.get_history

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:8080", "http://localhost:8081", "http://localhost:1500",
                   "http://103.170.123.206:1500"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


#
@app.on_event('startup')
def startup():
    if db.is_closed():
        db.connect()


#
#
@app.on_event('shutdown')
def shut_down():
    if not db.is_closed():
        db.close()


# @app.post('/')
# def create_account(account: schemas_account.Account):
#     account = account.dict()
#     return Account.create(**account)


@app.post('/products/users/signin')
def sign_in(account: schemas.sign_in.Sign_In):
    account = account.dict()
    query = Account.select().where(
        (Account.email == account['email']) & (Account.password == account['password'])).execute()
    query_len = list(query)
    if len(query_len):
        return {"code": 200, "data": query_len}
    else:
        return {"code": 400, "data": query_len}


@app.get('/products/match')
def get_list_match():
    return Matches.get_list()


@app.patch('/products/update/match')
def update_matches(matches: schemas.matches.Match):
    match_data = matches.dict()
    query = Matches.update(**match_data).where(Matches.id == match_data['id']).execute()
    return query


@app.put('/products/users/bets')
def user_history_bets(bets: schemas.bets.Bets):
    try:
        data_bets = bets.dict()
        query_email = Bets.select().where(Bets.email == data_bets['email']).execute()
        query_email = list(query_email)
        if len(query_email):
            query_match_number = Bets.select().where(
                (Bets.email == data_bets['email']) & (Bets.match_number == data_bets['match_number'])).execute()
            query_match_number = list(query_match_number)
            if len(query_match_number):
                Bets.update(**data_bets).where(Bets.id == query_match_number[0].__data__['id']).execute()
            else:
                Bets.insert(**data_bets).execute()
        else:
            Bets.insert(**data_bets).execute()
        return {"code": 200, "data": data_bets}
    except Exception as e:
        return {"code": 400, "error": e}


@app.post('/products/get/users/history')
def get_history_user(bets: schemas.get_history.History_Bets):
    try:
        data_bets = bets.dict()
        query_email = Bets.select().where(Bets.email == data_bets['email']).execute()
        query_email = list(query_email)
        return query_email
    except Exception as e:
        return e


@app.post('/products/get/users/score')
def get_score_user(bets: schemas.get_history.Match_number):
    try:
        data = bets.dict()
        find_data = Bets.select(Bets.email, Bets.match_number, Bets.choose, Bets.score).where(
            Bets.match_number == data['match_number']).execute()
        find_data = list(find_data)
        if len(find_data):
            for i in range(len(find_data)):
                if find_data[i].__data__['choose'] == data['result']:
                    find_data[i].__data__['score'] = 1
                    data_update = {"email": find_data[i].__data__['email'], "score": find_data[i].__data__['score']}
                    Bets.update(**data_update).where(
                        (Bets.email == data_update['email']) & (
                                Bets.match_number == find_data[i].__data__['match_number'])).execute()
        return find_data
    except Exception as e:
        return e


@app.patch('/product/update/myscore')
def update_score_account(bets: schemas.get_history.History_Bets):
    try:
        sum_score = 0
        data_account = bets.dict()
        find_score_by_name = Bets.select(Bets.email, Bets.score).where(Bets.email == data_account['email']).execute()
        find_score_by_name = list(find_score_by_name)
        if len(find_score_by_name):
            for i in range(0, len(find_score_by_name)):
                sum_score = sum_score + find_score_by_name[i].__data__['score']
        data_update = {"email": data_account['email'], "score": sum_score}
        Account.update(**data_update).where(Account.email == data_update['email']).execute()
        return {"code": 200, "isSuccess": True, "data": data_update}
    except Exception as e:
        return {"code": 400, "isSuccess": False, "data": e}


@app.get('/products/get/users')
def get_list_user():
    return Account.get_list()


@app.post('/products/get/infor')
def get_infor(account: schemas.sign_in.Sign_In):
    account = account.dict()
    get_infor_user = Account.select(Account.score).where(Account.email == account['email'])
    get_infor_user = list(get_infor_user)
    return get_infor_user
