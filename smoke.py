from flask import Request
from config import Config

from totoapicontroller.TotoDelegateDecorator import toto_delegate
from totoapicontroller.model.UserContext import UserContext
from totoapicontroller.model.ExecutionContext import ExecutionContext

@toto_delegate(config_class=Config)
def test_smoke(request: Request, user_context: UserContext, exec_context: ExecutionContext): 
    
    exec_context.logger.log(exec_context.cid, f"It's working!")
    
    return {"ok": True}