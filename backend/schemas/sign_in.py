from .base_schemas import SchemasBase


class Sign_In(SchemasBase):
    email: str
    password: str
