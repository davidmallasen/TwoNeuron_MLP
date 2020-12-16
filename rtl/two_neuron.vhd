library IEEE;
use IEEE.std_logic_1164.all;

use work.fixed_float_types.all;
use work.fixed_pkg.all;
use work.types_and_constants.all;

entity two_neuron is
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        data_in : in sfixed_array;
        result  : out sfixed_array
    );
end two_neuron;


architecture behavior of two_neuron is

    component psum is
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            data_in : in sfixed(intbits-1 downto -fracbits);
            weight  : in sfixed(intbits-1 downto -fracbits);
            bias    : in sfixed(intbits-1 downto -fracbits);
            step    : in integer range 0 to n;
            result  : out sfixed(intbits-1 downto -fracbits)
        );
    end component psum;

    signal input_data : sfixed_array;
    signal step : integer range 0 to n;
    signal neuron_result : sfixed(intbits-1 downto -fracbits);

    signal weights_row : sfixed_array;
    signal bias_row : sfixed(intbits-1 downto -fracbits);
    signal address_row : integer range 0 to n-1;
    signal weights_col : sfixed_array;
    signal bias_col : sfixed_array;
    signal address_col : integer range 0 to n-1;

begin

    process (clk, rst)
    begin
        if rst = '1' then
            step <= n;
        elsif rising_edge(clk) then
            if step = n then
                step <= 0;
                input_data <= data_in;
            else
                step <= step + 1;
            end if;
        end if;
    end process;

    address_row <= step when step < n else 0;
    address_col <= step - 1 when step > 0 else 0;

    stage_1: entity work.neuron
        port map(
            data_in => input_data,
            weights => weights_row, 
            bias => bias_row,
            result => neuron_result
        );

    stage_2: for i in 0 to n-1 generate
        psum_i: psum
            port map(
                clk => clk,
                rst => rst,
                data_in => neuron_result,
                weight => weights_col(i),
                bias => bias_col(i),
                step => step,
                result => result(i)
            );
    end generate;

    weights_buffer_row_1: entity work.weights_buffer_row
        port map(address_row, weights_row, bias_row);

    weights_buffer_col_1: entity work.weights_buffer_col
        port map(address_col, weights_col, bias_col);

end behavior;
