import pytest
import asyncio
from starkware.starknet.testing.starknet import Starknet


@pytest.fixture(scope='module')
def event_loop():
    return asyncio.new_event_loop()

# Reusable to save testing time.
@pytest.fixture(scope='module')
async def contract_factory():
    starknet = await Starknet.empty()
    contract = await starknet.deploy("gentest.cairo")
    return starknet, contract



@pytest.mark.asyncio
async def test_contract(contract_factory):
    starknet, contract = contract_factory
    x_0 = 10
    y_0 = 5
    vx = 0
    vy = 0
    ax = 0
    ay = 0
    dx = 1
    dy = 1



    ret = await contract.getoutput(x_0,y_0,vx,vy,ax,ay,dx,dy).invoke()


    print(ret)
