%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin, SignatureBuiltin
from starkware.cairo.common.math import (signed_div_rem, sign)


@external
func getoutput{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(x : felt,
      y : felt,
      vx: felt,
      vy: felt,
      ax: felt,
      ay: felt,
      dx: felt,
      dy: felt
      ) -> (
        final_location_x: felt,
        final_location_y: felt,
        new_velocity_x: felt,
        new_velocity_y: felt

    ):
    alloc_locals

    let (new_acceleration_x,new_acceleration_y) = applyforce(ax=ax,ay=ay,dx=dx,dy=dy)
    let (new_velocity_x,new_velocity_y) = updateVelocity(vx=vx,vy=vy,new_acceleration_x=new_acceleration_x,new_acceleration_y=new_acceleration_y)
    let (final_location_x,final_location_y,new_velocity_x,new_velocity_y) = updateLocation(x=x,y=y,nv_x=new_velocity_x,nv_y=new_velocity_y)

    return(final_location_x,final_location_y,new_velocity_x,new_velocity_y)
end


@view
func applyforce{
            syscall_ptr : felt*,
            pedersen_ptr : HashBuiltin*,
            range_check_ptr
            }(ax: felt,
              ay: felt,
              dx: felt,
              dy: felt,
              )->(
              ax: felt,
              ay: felt
        ):
        alloc_locals

        let ax = dx
        let ay = dy

        return(ax,ay)
end

@view
func updateVelocity{
            syscall_ptr : felt*,
            pedersen_ptr : HashBuiltin*,
            range_check_ptr
            }(vx: felt,
              vy: felt,
              new_acceleration_x: felt,
              new_acceleration_y: felt,
              )->(
              new_velocity_x: felt,
              new_velocity_y: felt
        ):
        alloc_locals

        let new_velocity_x = vx+new_acceleration_x
        let new_velocity_y = vy+new_acceleration_y


        return(new_velocity_x,new_velocity_y)
end

@view
func updateLocation{
            syscall_ptr : felt*,
            pedersen_ptr : HashBuiltin*,
            range_check_ptr
            }(x: felt,
              y: felt,
              nv_x: felt,
              nv_y: felt,
              )->(
              final_location_x: felt,
              final_location_y: felt,
              new_velocity_x: felt,
              new_velocity_y: felt
        ):
        alloc_locals

        let final_location_x  = nv_x+x
        let final_location_y  = nv_y+y
        return(final_location_x,final_location_y,nv_x,nv_y)
end
