from .base_schemas import SchemasBase


class History_Bets(SchemasBase):
    id_user: int


class Match_number(SchemasBase):
    result: str


class Update_score(SchemasBase):
    id_user: int
