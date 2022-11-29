from .base_schemas import SchemasBase


class Bets(SchemasBase):
    match_number: int
    date_time: str
    home_team: str
    away_team: str
    score: int
    id_match: int
    email: str
    username: str
    choose: str
    time_choose: str
    id_user: int

