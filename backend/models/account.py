from .base_models import BaseModel_db
from peewee import CharField
import json


class Account(BaseModel_db):
    username = CharField()
    email = CharField()
    password = CharField()
    role = CharField()
    score = CharField()
    id = CharField()

    class Meta:
        db_table = 'account'

    @classmethod
    def get_list(cls):
        query = cls.select().dicts()
        return list(query)

    def get_user(data):
        query = Account.select().where(Account.email == data['email'] and Account.password == data['password'])
        query = list(query)
        if len(query):
            return {"code": 200, "data": query}
        else:
            return {"code": 400, 'data': query}
