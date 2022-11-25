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
from schemas.get_history import History_Bets

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:8080", "http://localhost:8081", "http://localhost:1500", "103.170.123.206:1500"],
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


@app.post('/')
def create_account(account: schemas_account.Account):
    account = account.dict()
    return Account.create(**account)


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
def match():
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


@app.get('/products/get/users')
def test():
    return Account.get_list()
