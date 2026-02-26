-- TB EXAMPLE PFRL 2024-2025

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity tb_gen2_mod3 is
end tb_gen2_mod3;

architecture project_tb_arch of tb_gen2_mod3 is

    constant CLOCK_PERIOD : time := 20 ns;

    -- Signals to be connected to the component
    signal tb_clk : std_logic := '0';
    signal tb_rst, tb_start, tb_done : std_logic;
    signal tb_add : std_logic_vector(15 downto 0);

    -- Signals for the memory
    signal tb_o_mem_addr, exc_o_mem_addr, init_o_mem_addr : std_logic_vector(15 downto 0);
    signal tb_o_mem_data, exc_o_mem_data, init_o_mem_data : std_logic_vector(7 downto 0);
    signal tb_i_mem_data : std_logic_vector(7 downto 0);
    signal tb_o_mem_we, tb_o_mem_en, exc_o_mem_we, exc_o_mem_en, init_o_mem_we, init_o_mem_en : std_logic;

    -- Memory
    type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);
    signal RAM : ram_type := (OTHERS => "00000000");

    -- Scenario
    type scenario_config_type is array (0 to 16) of integer;
    constant SCENARIO_LENGTH : integer := 400;
    constant SCENARIO_LENGTH_STL : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(SCENARIO_LENGTH, 16));
    type scenario_type is array (0 to SCENARIO_LENGTH-1) of integer;

    signal scenario_config : scenario_config_type := (to_integer(unsigned(SCENARIO_LENGTH_STL(15 downto 8))),   -- K1
                                                      to_integer(unsigned(SCENARIO_LENGTH_STL(7 downto 0))),    -- K2
                                                      0,                                                        -- S
                                                      11, -3, 5, 9, -4, 5, 10, 1, -9, 45, 0, -45, 9, -1           -- C1-C14
                                                      );
    signal scenario_input : scenario_type := (-126, 107, -117, -10, -117, 37, 43, -124, -69, -84, -61, -34, 24, -28, -41, 79, -102, 10, -38, 5, 66, 63, -75, -30, 93, 112, 43, 91, -28, 89, -4, -105, 99, -66, -8, 33, -114, 54, -28, -75, -70, -18, 76, 51, 99, -43, -54, -79, 5, -33, -87, 85, -35, 3, 96, 53, 7, 21, -53, 58, -86, 126, -120, -36, -93, -10, -7, -122, -107, -103, 73, 111, -99, -37, 77, -47, -68, -46, 120, -56, -22, 6, -31, 67, 124, -84, 69, 23, 71, -63, -27, -56, -25, -25, 53, -102, 15, -102, 107, -56, -83, 46, 77, 63, 0, 41, -106, 121, 69, -18, -98, -70, -99, 30, 83, -54, 96, 61, -41, 66, -122, -69, 76, 99, 78, 12, 107, 32, -124, 27, -21, -118, -53, -34, -48, -6, 80, -12, -7, 46, -100, 4, -12, -29, 99, 85, -9, -108, -126, -25, -113, -85, 103, -94, 78, 67, 69, -1, 108, 86, -85, -71, 118, 24, 61, -32, -80, -111, 83, 36, 86, 83, 47, 107, -113, 106, -111, -34, -98, -89, 107, -77, 107, 112, 6, 96, 124, 120, -8, 70, -39, -61, -97, 120, -25, 96, -73, 61, 103, -115, 66, 75, 6, 106, 39, 5, 97, -98, -32, 3, 42, -59, 16, 38, -38, 101, -108, -39, 116, 127, -67, 105, -71, 101, 36, 29, 76, -66, 79, -85, 0, 91, -107, -94, 19, 121, -98, 120, -46, 13, -72, 32, -2, -113, -74, 68, -126, 53, -35, 69, 111, 10, -34, -121, 96, 32, -48, 59, 34, -2, -112, -54, -103, -85, 125, -62, 88, -62, -74, -73, -60, 81, -42, 28, 55, -56, 99, 19, 87, -82, -1, 65, -86, 83, 52, -74, -5, 91, 39, -121, -21, -6, -30, -66, 127, 73, -34, 88, 8, 22, 71, 45, -122, -121, -128, 127, -33, 11, 28, 50, 96, 26, 5, 120, -31, 74, 109, 48, -128, -8, -26, 18, 10, -120, 106, -66, -37, 76, -80, 54, 83, -84, 120, -40, 44, 118, -54, -127, 38, -103, -31, -92, 4, 107, -108, -65, 35, 127, -24, 19, -86, 8, -19, -76, 124, -74, -90, 93, -76, -49, 106, 117, -5, 41, -27, -95, -71, 123, -110, 17, -120, 3, -127, 46, 41, 0, 80, -34, -106, 112, -7, 115, -54, -39, 52, -12, -19, -126, 111, -91, -11, -44, -80, -48, 22, 59, 109, -107, -30, -69);

    signal scenario_output : scenario_type :=(127, -128, 127, -128, 127, 10, -87, 6, -103, 70, 34, 107, -12, -2, 114, -128, 127, -128, 109, 54, 57, -128, -15, 64, 106, -1, 36, -128, 123, -128, -91, 127, -128, 127, -31, -124, 127, -124, 32, -69, 29, 127, 38, 116, -128, -36, -128, 92, -16, -26, 127, -109, 109, 38, 11, -13, -32, -123, 121, -128, 127, -128, 127, -128, 127, 12, -68, -16, -69, 127, 127, -116, 2, 22, -50, 3, -78, 127, -127, 80, -73, -11, 114, 92, -128, 127, -128, 127, -128, 22, -112, 55, -7, 127, -128, 127, -128, 127, -128, 39, 24, 71, 87, -69, 16, -128, 127, -68, 36, -128, -52, -76, 127, 109, -60, 127, -74, -42, 68, -128, 54, 63, 127, 81, -90, 64, -92, -128, 64, -92, -24, 8, -7, 43, 54, 117, -44, 21, 7, -128, 103, -73, 39, 127, 24, -24, -128, -128, 60, -60, 65, 127, -128, 127, -86, 118, -108, 93, -26, -128, -86, 117, -26, 127, -128, -65, -128, 127, 0, 127, -23, -23, 58, -128, 127, -128, 127, -128, 34, 127, -128, 127, -47, -7, 50, -16, 65, -128, 32, -128, -11, -128, 127, -116, 127, -128, 127, -2, -128, 127, -65, 37, 92, -93, -11, 53, -128, 59, -68, 118, -81, 71, -7, -37, 127, -128, 85, 63, 127, -128, 127, -128, 127, -128, 75, 8, -128, 127, -128, 127, 39, -128, -6, -2, 127, -128, 127, -128, 127, -128, 127, -45, -69, -27, 127, -128, 127, -128, 127, 29, -32, -63, -128, 127, -38, 22, 45, -39, 27, -128, 7, -101, 37, 127, -128, 127, -128, 32, -103, 6, 127, -79, 127, -18, -85, 127, -118, 127, -128, 66, 2, -106, 127, -66, -48, -1, 54, 34, -128, 15, -45, 55, -52, 127, -5, -28, 58, -127, 59, 2, 6, -128, -78, -128, 127, -87, 127, -79, 57, 73, -54, -37, 80, -128, 127, -26, 21, -128, 27, -93, 127, 6, -128, 127, -128, 117, 34, -124, 127, -10, -108, 127, -128, 127, 13, -112, -118, 57, -128, 127, -128, 127, 127, -128, 28, -17, 127, -76, 54, -128, 103, -57, -22, 127, -128, 28, 85, -128, 81, 73, 101, -42, 6, -128, -74, -54, 127, -128, 127, -128, 127, -128, 127, -18, 64, 75, -128, -92, 127, -111, 127, -128, 24, 0, -24, 37, -128, 127, -128, 127, -128, 5, 1, 73, 92, 127, -128, 38, -128, 127);

    signal memory_control : std_logic := '0';      -- A signal to decide when the memory is accessed
                                                   -- by the testbench or by the project

    constant SCENARIO_ADDRESS : integer := 1234;    -- This value may arbitrarily change

    component project_reti_logiche is
        port (
                i_clk : in std_logic;
                i_rst : in std_logic;
                i_start : in std_logic;
                i_add : in std_logic_vector(15 downto 0);

                o_done : out std_logic;

                o_mem_addr : out std_logic_vector(15 downto 0);
                i_mem_data : in  std_logic_vector(7 downto 0);
                o_mem_data : out std_logic_vector(7 downto 0);
                o_mem_we   : out std_logic;
                o_mem_en   : out std_logic
        );
    end component project_reti_logiche;

begin
    UUT : project_reti_logiche
    port map(
                i_clk   => tb_clk,
                i_rst   => tb_rst,
                i_start => tb_start,
                i_add   => tb_add,

                o_done => tb_done,

                o_mem_addr => exc_o_mem_addr,
                i_mem_data => tb_i_mem_data,
                o_mem_data => exc_o_mem_data,
                o_mem_we   => exc_o_mem_we,
                o_mem_en   => exc_o_mem_en
    );

    -- Clock generation
    tb_clk <= not tb_clk after CLOCK_PERIOD/2;

    -- Process related to the memory
    MEM : process (tb_clk)
    begin
        if tb_clk'event and tb_clk = '1' then
            if tb_o_mem_en = '1' then
                if tb_o_mem_we = '1' then
                    RAM(to_integer(unsigned(tb_o_mem_addr))) <= tb_o_mem_data after 1 ns;
                    tb_i_mem_data <= tb_o_mem_data after 1 ns;
                else
                    tb_i_mem_data <= RAM(to_integer(unsigned(tb_o_mem_addr))) after 1 ns;
                end if;
            end if;
        end if;
    end process;

    memory_signal_swapper : process(memory_control, init_o_mem_addr, init_o_mem_data,
                                    init_o_mem_en,  init_o_mem_we,   exc_o_mem_addr,
                                    exc_o_mem_data, exc_o_mem_en, exc_o_mem_we)
    begin
        -- This is necessary for the testbench to work: we swap the memory
        -- signals from the component to the testbench when needed.

        tb_o_mem_addr <= init_o_mem_addr;
        tb_o_mem_data <= init_o_mem_data;
        tb_o_mem_en   <= init_o_mem_en;
        tb_o_mem_we   <= init_o_mem_we;

        if memory_control = '1' then
            tb_o_mem_addr <= exc_o_mem_addr;
            tb_o_mem_data <= exc_o_mem_data;
            tb_o_mem_en   <= exc_o_mem_en;
            tb_o_mem_we   <= exc_o_mem_we;
        end if;
    end process;

    -- This process provides the correct scenario on the signal controlled by the TB
    create_scenario : process
    begin
        wait for 50 ns;

        -- Signal initialization and reset of the component
        tb_start <= '0';
        tb_add <= (others=>'0');
        tb_rst <= '1';

        -- Wait some time for the component to reset...
        wait for 50 ns;

        tb_rst <= '0';
        memory_control <= '0';  -- Memory controlled by the testbench

        wait until falling_edge(tb_clk); -- Skew the testbench transitions with respect to the clock


        for i in 0 to 16 loop
            init_o_mem_addr<= std_logic_vector(to_unsigned(SCENARIO_ADDRESS+i, 16));
            init_o_mem_data<= std_logic_vector(to_unsigned(scenario_config(i),8));
            init_o_mem_en  <= '1';
            init_o_mem_we  <= '1';
            wait until rising_edge(tb_clk);
        end loop;

        for i in 0 to SCENARIO_LENGTH-1 loop
            init_o_mem_addr<= std_logic_vector(to_unsigned(SCENARIO_ADDRESS+17+i, 16));
            init_o_mem_data<= std_logic_vector(to_unsigned(scenario_input(i),8));
            init_o_mem_en  <= '1';
            init_o_mem_we  <= '1';
            wait until rising_edge(tb_clk);
        end loop;

        wait until falling_edge(tb_clk);

        memory_control <= '1';  -- Memory controlled by the component

        tb_add <= std_logic_vector(to_unsigned(SCENARIO_ADDRESS, 16));

        tb_start <= '1';

        while tb_done /= '1' loop
            wait until rising_edge(tb_clk);
        end loop;

        wait for 5 ns;

        tb_start <= '0';

        wait;

    end process;

    -- Process without sensitivity list designed to test the actual component.
    test_routine : process
    begin

        wait until tb_rst = '1';
        wait for 25 ns;
        assert tb_done = '0' report "TEST FALLITO o_done !=0 during reset" severity failure;
        wait until tb_rst = '0';

        wait until falling_edge(tb_clk);
        assert tb_done = '0' report "TEST FALLITO o_done !=0 after reset before start" severity failure;

        wait until rising_edge(tb_start);

        while tb_done /= '1' loop
            wait until rising_edge(tb_clk);
        end loop;

        assert tb_o_mem_en = '0' or tb_o_mem_we = '0' report "TEST FALLITO o_mem_en !=0 memory should not be written after done." severity failure;

        for i in 0 to SCENARIO_LENGTH-1 loop
            assert RAM(SCENARIO_ADDRESS+17+SCENARIO_LENGTH+i) = std_logic_vector(to_unsigned(scenario_output(i),8)) report "TEST FALLITO @ OFFSET=" & integer'image(17+SCENARIO_LENGTH+i) & " expected= " & integer'image(scenario_output(i)) & " actual=" & integer'image(to_integer(unsigned(RAM(SCENARIO_ADDRESS+17+SCENARIO_LENGTH+i)))) severity failure;
        end loop;

        wait until falling_edge(tb_start);
        assert tb_done = '1' report "TEST FALLITO o_done == 0 before start goes to zero" severity failure;
        wait until falling_edge(tb_done);

        assert false report "Simulation Ended! TEST PASSATO (EXAMPLE)" severity failure;
    end process;

end architecture;

