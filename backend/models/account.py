from .base_models import BaseModel_db
from peewee import CharField, IntegerField


class Account(BaseModel_db):
    username = CharField()
    email = CharField()
    password = CharField()
    role = CharField()
    score = IntegerField()
    id = IntegerField()

    class Meta:
        db_table = 'account'

    @classmethod
    # def get_list(cls):
    #     query = cls.select().order_by(score)
    #     return list(query)

    def get_user(data):
        query = Account.select().where(Account.email == data['email'] and Account.password == data['password'])
        query = list(query)
        if len(query):
            return {"code": 200, "data": query}
        else:
            return {"code": 400, 'data': query}
