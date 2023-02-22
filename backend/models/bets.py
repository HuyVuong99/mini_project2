from .base_models import BaseModel_db
from peewee import CharField, IntegerField


class Bets(BaseModel_db):
    match_number = IntegerField()
    date_time = CharField()
    home_team = CharField()
    away_team = CharField()
    id_match = IntegerField()
    email = CharField()
    choose = CharField()
    username = CharField()
    id = IntegerField()
    score = IntegerField()
    time_choose = CharField()
    id_user = IntegerField()

    class Meta:
        db_table = 'history_bets'

    @classmethod
    def get_list(cls):
        query = cls.select().dicts()
        return list(query)
