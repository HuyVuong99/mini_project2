from .base_schemas import SchemasBase


class History_Bets(SchemasBase):
    id_user: int


class Match_number(SchemasBase):
    match_number: int
    result: str


class Update_score(SchemasBase):
    email: str
