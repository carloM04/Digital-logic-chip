-- TB EXAMPLE PFRL 2024-2025

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity tb_gen3_mod5 is
end tb_gen3_mod5;

architecture project_tb_arch of tb_gen3_mod5 is

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
    constant SCENARIO_LENGTH : integer := 500;
    constant SCENARIO_LENGTH_STL : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(SCENARIO_LENGTH, 16));
    type scenario_type is array (0 to SCENARIO_LENGTH-1) of integer;

    signal scenario_config : scenario_config_type := (to_integer(unsigned(SCENARIO_LENGTH_STL(15 downto 8))),   -- K1
                                                      to_integer(unsigned(SCENARIO_LENGTH_STL(7 downto 0))),    -- K2
                                                      1,                                                        -- S
                                                      11, -3, 5, 9, -4, 5, 10, -4, 3, -6, 10, 8, -2, 1   -- C1-C14
                                                      );
    signal scenario_input : scenario_type := (96, 108, -105, -38, 91, 115, 61, 38, 28, 113, 91, 27, -37, -41, -91, -105, 118, -7, 111, -83, 79, -50, -95, 123, 3, -37, 60, -40, 63, -92, 8, -85, -25, -93, -7, 82, -116, 97, -93, 76, 73, 61, 48, -103, 52, -11, -5, 58, -58, 37, 68, 20, 123, 9, 81, 54, -71, 32, -90, 103, 71, -75, -80, -106, -28, 71, 5, 23, -81, -89, 117, -62, 3, -52, -101, 105, 11, -120, -57, 99, -111, -51, 6, -118, 105, 120, 92, 27, -20, 59, 104, 34, -89, -78, -123, 99, -92, 93, -96, 55, -32, -41, 101, -92, 17, 111, -61, -109, 44, -38, -107, 15, -31, -39, 62, -72, 13, 90, 50, 107, 76, -61, -110, 29, -98, 63, 74, 16, -60, -104, -21, 88, -30, 20, -104, -19, -92, -61, 118, 97, -28, -36, 111, 79, -107, -38, 100, 31, -48, -81, -53, 74, 48, -88, -97, -126, -89, -99, 84, -116, -104, 60, 21, -77, -16, 90, 126, -83, 44, -85, 97, -9, -115, -3, 27, -5, -14, -78, 27, 102, -54, 110, 101, 97, 106, -31, -8, 6, -18, -64, 125, -48, -4, -45, -23, 73, -83, -128, -122, 73, 22, 47, 14, 22, 61, -76, -25, 68, -120, 57, 2, 88, 59, -14, -57, -24, 62, -108, 124, -108, -87, -117, 49, -10, -42, -54, 69, -2, -102, 52, -101, -108, -20, 110, 87, 73, -17, 27, -120, -106, -103, -77, 43, -45, 91, -46, -46, -99, 110, 79, 42, -115, 87, -124, -50, -111, 2, -69, -9, -63, -82, -37, -5, 62, -88, -57, 39, -61, -57, -77, -29, 2, -118, -78, 54, -99, -120, -7, 12, -112, 83, -103, -83, 120, -91, 117, 126, -23, 61, 114, -111, -124, -91, -99, 71, -75, -121, 20, -84, 86, 80, -37, -67, 66, -30, -115, -9, -115, -113, 73, 37, 81, 68, 104, -114, 68, 9, 15, -36, 74, 6, 77, 43, 113, -20, -83, 78, -86, -9, 41, 124, -59, 86, -82, -28, -60, -90, -50, -72, -32, 93, 18, 20, -62, -38, -22, 83, -41, 24, -37, 21, -87, 103, -115, 41, -9, -3, -50, -2, 50, 84, -74, 22, 82, -107, -100, 85, -111, 64, 106, -115, 112, 12, 11, -17, -53, 5, -13, -111, 75, -85, 89, 103, 101, 40, 16, -66, 16, 34, -92, 89, 22, 13, 123, -2, -85, 116, 127, 117, 2, -53, -57, -20, 67, -101, 103, 46, 28, 32, -55, 93, 120, 56, 44, -93, 75, 65, -8, -77, -10, -106, 109, -110, -83, -34, 48, -20, -81, 31, -122, -44, -14, -73, -65, 94, 68, 57, 94, -60, 53, 57, -93, -14, -25, -42, 40, 86, -66, -74, -51, -76, 111, -41, 44, 126, 64, -71, 4, -74, -128, -47, 71, 93, 35, -12, -80, -77, -92, 12, 88, -105, -67, -54, -2, 99, 112, -42, -23, -66, -46, -17, -35, -60, 81, 5, -83, 65, -29, -92, -117, 31, -81, -30, -79, -33, -43, -121, 13, -75, -124);

    signal scenario_output : scenario_type :=(32, -2, -28, 11, 20, 22, 11, 1, 8, 23, 6, -5, -15, -13, -31, 9, 21, 6, 17, -22, 25, -43, 13, 24, -20, 15, -3, -2, 5, -23, 4, -23, 0, -22, 28, -8, -4, 18, -27, 42, -1, 23, -14, -15, 15, -18, 19, -1, -11, 25, 0, 19, 18, -6, 26, -18, -4, -4, -14, 42, -13, -15, -20, -23, 15, 12, 3, 2, -36, 11, 12, -20, 15, -36, 4, 28, -22, -21, 11, 2, -31, 17, -22, -3, 45, 13, 21, -8, -4, 18, 13, -11, -21, -29, -1, 13, -9, 22, -27, 27, -31, 21, 4, -27, 34, 1, -29, -2, 6, -26, -2, 6, -17, 14, 2, -18, 26, 9, 14, 26, -5, -31, -6, -5, -13, 37, 1, 0, -23, -21, 14, 8, -1, -2, -26, 1, -29, 15, 35, 6, -10, 3, 26, -8, -25, 11, 13, -3, -10, -22, 1, 23, -6, -22, -24, -25, -18, 5, 15, -41, 10, 13, -7, -7, 7, 30, 2, -9, 1, -19, 34, -32, -8, 7, -1, 4, -9, -13, 28, 2, 0, 38, 4, 29, 1, -19, 0, -4, -14, 9, 18, -21, 9, -24, 13, 3, -30, -25, -6, 24, 4, 19, -6, 12, -2, -25, 18, -11, -13, 24, -5, 31, -2, -9, -17, 10, -8, -2, 22, -45, -7, -18, 21, -8, -4, 0, 19, -23, -1, 3, -38, -3, 11, 29, 20, 4, -6, -9, -39, -12, -26, 8, 6, 3, 20, -22, -10, -7, 35, 10, -8, -11, 5, -40, 0, -22, 6, -13, 6, -22, -6, -4, 12, 4, -27, 8, -3, -15, -6, -18, 6, -8, -29, 8, 1, -32, -5, 8, -15, 0, 17, -47, 28, 3, -12, 58, -6, -1, 27, -8, -39, -14, -31, 3, 19, -36, 4, -5, -8, 41, -2, -14, -1, 9, -28, -7, -5, -38, 9, 21, 10, 24, 18, -4, -21, 23, -12, 5, 0, 14, 1, 19, 8, 19, -31, 3, 2, -24, 15, 18, 9, -5, 11, -36, 5, -27, -9, -6, -13, 17, 18, 0, 0, -20, -6, 8, 10, -8, 6, -8, -5, -1, 11, -28, 26, -15, 4, -11, 7, 20, 2, -19, 24, -6, -37, 11, -1, -21, 52, -18, -4, 31, -20, 12, -18, -7, 7, -22, 0, 9, -15, 44, 10, 20, 0, -11, -17, 15, -14, -2, 28, -13, 25, 18, -25, 4, 31, 19, 19, -18, -17, -18, 12, -2, -7, 37, -9, 19, -9, -4, 35, 9, 14, -11, -17, 27, -2, -8, -9, -18, -2, 20, -42, 3, -4, 14, -18, 0, -5, -31, 10, -11, -14, 9, 27, 6, 26, -1, -17, 25, -17, -15, 4, -15, 2, 22, 2, -23, -6, -24, 9, 23, -14, 35, 17, -7, -13, -3, -34, -15, 7, 25, 18, 2, -14, -23, -18, -13, 26, 1, -26, -2, -14, 17, 34, 5, -13, -7, -23, -1, -1, -11, 4, 22, -21, 1, 10, -23, -21, -9, 2, -18, 2, -20, 4, -23, -9, 7, -32, -4);

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

