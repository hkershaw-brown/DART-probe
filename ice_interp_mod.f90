module ice_interp_mod

use model_mod, only: quad_idw_interp
use utilities_mod, only: initialize_utilities

implicit none

public :: quad_idw_interp_f2py
contains

subroutine quad_idw_interp_f2py(lon_in, lat, x_corners, y_corners, p, expected_obs)

! Wrapper for quad_idw_interp to make it compatible with f2py

! Arguments
real(8), intent(inout)  :: lon_in       ! Interpolation point longitude (degrees)
real(8), intent(in)     :: lat          ! Interpolation point latitude (degrees)
real(8), intent(in)     :: x_corners(4) ! Quadrilateral corner longitudes (degrees)
real(8), intent(in)     :: y_corners(4) ! Quadrilateral corner latitudes (degrees)
real(8), intent(in)     :: p(4)         ! Values at the quadrilateral corners
real(8), intent(out)    :: expected_obs ! Interpolated value at (lon, lat)

call initialize_utilities()
call quad_idw_interp(lon_in, lat, x_corners, y_corners, p, expected_obs)

end subroutine quad_idw_interp_f2py

end module ice_interp_mod