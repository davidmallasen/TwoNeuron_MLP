library ieee;
use ieee.std_logic_1164.all;

use work.fixed_float_types.all;
use work.fixed_pkg.all;

package types_and_constants is

    -- Number of inputs to the neuron as well as number of neurons per layer.
    constant n              : integer := 8;  -- UPDATE psum_intbits!
    -- Number of integer bits for input/output data and weights.
    constant intbits        : integer := 12;  -- UPDATE psum_intbits!
    -- Number of fractional bits for input/output data and weights.
    constant fracbits       : integer := 20;
    -- Number of integer bits for the partial sums. Needed to avoid loss of precision.
    constant psum_intbits   : integer := 31;  -- 2*intbits + n - 1

    type sfixed_array is array (0 to n-1) of sfixed(intbits-1 downto -fracbits);
    type sfixed_mat is array (0 to n-1) of sfixed_array;

end package types_and_constants;