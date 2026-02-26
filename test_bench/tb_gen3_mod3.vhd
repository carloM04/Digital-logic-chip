-- TB EXAMPLE PFRL 2024-2025

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity tb_gen3_mod3 is
end tb_gen3_mod3;

architecture project_tb_arch of tb_gen3_mod3 is

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
    constant SCENARIO_LENGTH : integer := 1000;
    constant SCENARIO_LENGTH_STL : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(SCENARIO_LENGTH, 16));
    type scenario_type is array (0 to SCENARIO_LENGTH-1) of integer;

    signal scenario_config : scenario_config_type := (to_integer(unsigned(SCENARIO_LENGTH_STL(15 downto 8))),   -- K1
                                                      to_integer(unsigned(SCENARIO_LENGTH_STL(7 downto 0))),    -- K2
                                                      0,                                                        -- S
                                                      11, -3, 5, 9, -4, 5, 10, 1, -9, 45, 0, -45, 9, -1           -- C1-C14
                                                      );
    signal scenario_input : scenario_type := (46, 121, 50, -49, 50, 81, 69, -84, 99, 74, 68, 30, -105, -31, 8, 66, 28, 122, -38, 7, -82, -65, 30, 81, 19, 70, -53, -31, -90, 92, 8, -25, 90, 115, 61, 86, -84, 37, -43, 114, -18, 20, -30, -99, -111, -88, -94, -28, -4, -56, -10, 79, 36, -79, 107, 11, 121, -67, -82, -13, -100, -55, 84, 120, -97, 23, 62, -71, 92, 49, -87, 68, 92, 102, -44, -110, -87, -80, 117, 1, 119, 63, 0, -25, 26, -36, -6, 64, -112, -16, -25, 41, -33, -26, 63, 107, -53, -109, -49, -17, 77, 59, 27, -53, 33, 37, -65, -41, -71, 118, -94, 60, 12, -70, 45, 7, -9, -79, -62, -47, 70, -24, -34, 102, 2, 109, 63, 112, 82, -9, 10, -124, 81, -55, 75, 108, 56, -24, -68, 65, -92, -37, -89, -102, 73, 42, 124, 102, -111, -92, 1, -76, 75, -21, 97, -85, -5, -87, 13, -7, 41, 42, -87, 115, -45, -128, -23, 104, -46, -112, 81, 74, -61, 49, -93, 31, 105, 42, 89, -5, 108, -53, -79, 99, -25, 10, -23, -64, -118, 27, -41, 86, -5, 81, 30, -100, 89, 12, 51, 34, -66, 53, -2, -42, -101, 71, 127, 30, 29, 96, -70, -70, 91, 69, 64, -91, 20, 89, 3, -12, -72, -118, 111, -74, -4, -73, 110, 102, 95, 88, 18, -34, 66, -60, -127, 46, 24, 12, 54, 20, -128, 1, 105, -56, 18, 104, 66, 75, 4, -76, 77, -73, -29, -110, 41, 12, 93, 22, 117, 15, 93, 44, -2, 36, 127, -9, -105, -51, -37, 87, 33, 118, 112, 70, 90, 109, 77, -88, 17, -84, 107, 93, 43, 88, 47, 29, 18, -81, -33, 104, 107, -51, 110, -7, -6, -17, 53, 67, 125, -49, 74, -126, 97, 95, 99, 124, 28, -8, -57, 10, 104, 45, 8, 126, 12, 50, 124, 51, -126, -96, 89, 47, 10, 0, -70, 0, -38, -75, 31, 51, 120, -3, -22, -83, 72, -115, -13, 23, 89, -91, -35, 75, 8, 117, 94, -84, 14, 75, 11, -54, -79, -119, 74, 113, 37, 65, -39, -15, -34, -87, 45, 86, 126, -96, -63, -95, -61, -104, -98, -42, -37, -78, -119, -121, -97, 24, -120, -73, 16, -1, -61, -92, -51, 127, -27, -27, 19, 8, 67, 33, 79, 48, 40, -62, 32, -7, 27, 85, -36, -97, -125, 124, 98, 25, -7, 73, 116, -29, 114, 84, -23, 111, -61, 126, 24, 29, -90, 36, 31, 97, -121, -123, 35, -9, -113, 41, -55, -57, 93, 82, 22, 10, 9, -44, -109, -78, -55, 80, -96, 111, -53, 86, 49, -94, 70, -4, -32, -76, -62, 81, -3, -15, -103, 18, 55, 21, 26, 86, -123, -90, -100, -29, -107, 43, -95, 81, 26, 25, 61, -71, 45, 96, -72, 18, 106, -3, -72, -81, 6, 89, -120, -71, 9, 19, 11, -60, 53, -128, 82, -62, 124, 10, 94, -118, 86, -74, 121, 96, 111, -75, 76, 50, 33, 125, 66, -48, -123, -2, 21, 61, -71, 57, 22, 66, -13, 127, 18, 90, -99, -39, 19, 98, 15, -103, 90, -17, 41, 96, -100, 68, 47, 72, 116, -117, -124, -123, -112, 27, 64, -36, 36, -60, 125, -14, -62, -80, -22, -46, 59, -97, 59, 68, 55, 42, 97, 18, 1, -84, 104, 94, 51, -19, 69, -83, 97, -55, -15, 71, 90, 61, 63, -65, -29, -63, -118, -42, 73, 112, 123, -16, -119, -121, -65, -74, -50, -86, -86, 48, -43, 117, 10, -72, 90, 99, -123, -50, -57, 116, -107, 19, 68, -13, -128, 11, 43, 72, 32, -10, -71, 80, 95, 49, -44, 16, -101, -50, 13, -67, -122, -54, 79, 90, 12, -106, 80, 19, 59, -71, 107, 124, 123, -120, -107, 20, 8, 8, -71, -71, 69, 36, -106, -69, 125, -11, -99, 55, -52, 101, 104, -2, 66, -72, 107, -91, -62, -71, -55, 74, -22, 27, -92, -85, 1, 44, 50, -91, 54, 124, -48, -82, 85, 18, -35, 63, -49, 47, 45, -27, -62, 23, 115, 100, -20, -75, 55, -47, -52, 23, -29, -13, 49, -89, -64, -13, 56, 107, 21, -85, -49, 106, -58, -116, -89, -66, -98, -65, -10, -113, -11, -69, -32, -110, 127, 92, -96, 22, 94, -6, 20, 42, 21, -8, 3, -104, 115, -81, -92, 71, 127, 10, 106, -121, 42, -128, 68, 51, -21, -121, 49, -39, -11, -56, -53, -66, 33, 19, 108, 84, 8, 85, 124, 38, -68, 41, 125, -26, -70, -111, 78, -47, 122, 123, 76, -127, 34, 33, -93, -49, 102, -22, -41, 108, -128, 103, 9, 61, 86, -107, -9, 119, -61, -75, -97, 56, 83, 43, 124, 104, -114, -73, -102, -126, -64, 94, 80, -115, -111, -38, 54, 21, -44, 4, 87, -35, -62, -67, -113, 94, 40, -120, 18, -6, -39, -80, -8, -103, -38, -90, 87, -70, 102, -56, 71, 6, 82, 104, 102, -102, -24, -106, 25, -82, -58, 58, 38, -38, -8, -99, -115, -63, -102, -42, 19, -89, 67, -73, 16, -27, 68, -92, -85, 118, -94, 42, -66, -20, 14, 114, 76, 75, 12, 108, -46, 103, -92, -92, 66, 11, 41, -111, -30, 17, 63, 76, 78, 26, -44, -121, 13, -74, -34, 24, -118, -4, 89, 9, -116, -35, 29, -62, -7, 71, 94, 9, -31, 84, -119, 34, 16, -11, 23, -98, 45, -62, -115, 54, 82, 42, -61, -29, -7, 25, -94, 104, -98, -88, -6, -4, -61, -126, 58, 39, -50, 62, -7, -73, 75, -10, -30, 21, 100, -120, -38, 28, 58, 16, 77, -3, -10, 107, 26, 28, 21, -14, 23, -50, 16, 102, -36, -24, 28, 83, 94, -104, -22, 119, 6, 21, -58, -78, 69, 76, -41, 11, -54, 41, -74, 58, 81, -16, 115, 22, 26, 20, -78, 36, -98, 104, 35, -85, -22, -42, 122, -7, 4, 50, -29, 113, 115, 10, -104, -85, -32, -82, -49, 26, 36, -37, -39, -107);

    signal scenario_output : scenario_type :=(7, 31, 0, -18, 68, -22, 50, -79, 127, -47, 8, 24, -53, 57, -22, 39, -52, 96, -100, 74, -48, 11, 12, 21, -49, 69, -74, 69, -78, 96, -54, 5, 57, 13, -29, 86, -100, 127, -108, 118, -101, 50, -29, -27, -17, -7, -39, -1, -3, -27, 10, 16, 11, -70, 127, -121, 111, -91, 10, 31, -55, 15, 7, 38, -100, 81, 27, -88, 95, -10, -55, 103, -38, 28, -43, -3, 29, -66, 113, -112, 100, -29, 12, -7, 37, -33, -7, 57, -112, 87, -58, 38, -34, 16, 8, 18, -55, 2, 28, -27, 33, -26, 27, -32, 39, -2, -53, 58, -88, 127, -128, 117, -31, -42, 69, -53, 12, -36, 23, -42, 52, -45, -8, 96, -85, 107, -33, 50, 12, -37, 80, -118, 127, -123, 90, -7, -5, 13, -43, 90, -124, 53, -29, -37, 87, -59, 36, 21, -66, 23, 47, -102, 114, -119, 119, -128, 100, -86, 64, -43, 10, 42, -102, 127, -96, 1, 10, 31, -55, -18, 73, -10, -81, 119, -98, 70, 23, -44, 87, -74, 102, -60, -12, 100, -106, 48, -31, 7, -59, 88, -102, 102, -79, 59, 10, -75, 127, -81, 34, 21, -58, 76, -58, 26, -38, 64, 6, -21, 7, 60, -58, 13, 69, -59, 57, -63, 64, 12, -50, 16, 7, -78, 127, -128, 112, -79, 102, -28, 21, 26, 10, -28, 60, -48, -33, 78, -45, 0, 10, 16, -59, 44, 42, -85, 63, 34, -27, 31, 11, -57, 108, -128, 80, -87, 92, -70, 80, -59, 106, -65, 78, -12, 15, 5, 45, -48, -13, 47, -44, 71, -49, 70, 12, 15, 39, 8, 39, -85, 124, -103, 108, -23, -3, 55, -8, 2, 24, -27, 22, 24, 29, -88, 127, -86, 48, -11, 45, -29, 85, -121, 127, -128, 127, -37, 15, 47, -27, 33, -7, 17, 32, -7, -13, 97, -52, 44, 22, -5, -32, 11, 60, -53, -2, 26, -48, 36, -23, -26, 57, -37, 55, -60, 57, -78, 113, -128, 90, -50, 55, -80, 39, 55, -60, 58, 18, -60, 70, 1, -29, -16, 23, -49, 68, -5, -37, 65, -52, 27, 1, -38, 66, -44, 59, -107, 68, -58, 2, -45, -18, -7, -31, -33, -31, -7, -57, 48, -103, 23, 2, -32, -18, 6, -34, 85, -97, 34, 27, -24, 49, -24, 48, -22, 44, -55, 74, -34, 5, 29, -58, 34, -52, 101, -54, 13, 12, 26, 57, -74, 106, 3, -63, 127, -128, 127, -98, 73, -70, 92, -73, 66, -88, 10, 36, -31, -75, 92, -66, -1, 58, -21, -2, 10, 0, -15, -32, 23, -60, 100, -128, 127, -128, 96, 0, -78, 112, -76, 11, -3, -27, 60, -80, 45, -54, 54, -7, -3, -16, 63, -116, 58, -64, 42, -112, 117, -128, 119, -55, 1, 58, -68, 53, 33, -73, 57, 23, -50, 8, 0, -13, 45, -108, 50, 3, -27, 22, -71, 117, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -69, 88, -92, 122, -22, -1, 54, -24, 1, -26, 57, -50, 53, -85, 102, -58, 71, -66, 122, -103, 108, -97, 71, -17, 18, 0, -68, 127, -91, 24, 69, -116, 127, -38, -3, 57, -109, 34, -15, -38, 18, 3, -69, 100, -103, 121, -98, 23, -22, 31, -73, 91, -116, 106, -27, 21, -1, 52, -43, 58, -58, 101, -39, 28, -39, 109, -128, 127, -102, 49, 24, 7, -13, 45, -60, 33, -23, -27, 18, 24, -13, 23, -33, -8, -11, -1, -52, -3, -22, -42, 80, -111, 102, -42, -18, 58, 10, -106, 102, -95, 121, -128, 92, -17, -7, -48, 76, -31, 15, -13, 28, -33, 73, -24, 16, -45, 68, -74, 15, 0, -45, -10, 7, 22, -23, 21, -63, 122, -93, 88, -79, 119, -52, 55, -78, 34, 33, -53, 11, -18, -12, 34, -23, -28, -3, 71, -66, -38, 118, -106, 88, 3, -54, 113, -127, 127, -128, 54, -13, -36, 65, -96, 63, -60, 11, 15, -26, 37, -65, 65, 17, -49, -2, 75, -44, -28, 87, -81, 63, -15, -7, 2, 28, 12, 0, -5, -24, 74, -69, 0, 33, -36, -10, 39, -75, 36, 2, 0, 13, -15, -2, -11, 64, -100, 2, -10, -15, -39, -23, 23, -97, 65, -86, 60, -92, 97, -21, -63, 74, 22, -48, 38, 6, 0, -21, 57, -113, 127, -118, 26, 42, 26, -88, 127, -128, 127, -128, 116, -60, 16, -68, 102, -100, 34, -39, 13, -34, 54, -39, 50, 10, -7, 53, 13, 3, -13, 43, 29, -75, 49, -66, 123, -121, 114, -43, 54, -90, 96, -23, -38, 2, 63, -59, -27, 127, -128, 127, -96, 28, 48, -76, 43, 49, -108, 57, -39, 53, 0, -13, 38, 26, -92, 54, -39, -15, -11, 17, -11, -68, 36, -7, 7, -16, -8, 6, 37, -66, 5, 22, -71, 74, -31, -75, 88, -55, 1, -45, 45, -95, 66, -103, 127, -128, 127, -128, 123, -57, 64, -17, 54, -102, 107, -108, 79, -78, 8, 28, -17, -39, 33, -53, -22, 8, -53, -7, 34, -111, 121, -123, 92, -80, 73, -66, -24, 127, -128, 127, -91, 53, -15, 53, -26, 57, -43, 117, -128, 127, -101, 11, 69, -88, 64, -80, 63, -10, 15, 3, 13, -10, 12, -59, 75, -81, 0, 38, -87, 52, 0, -23, -37, 28, 13, -54, 37, 7, 10, -2, -33, 111, -128, 112, -39, -26, 57, -101, 90, -59, -23, 66, -33, 7, -29, 34, -28, 49, -119, 127, -128, 32, 5, -32, 0, -55, 71, -26, -52, 70, -26, -43, 86, -60, 21, -15, 66, -114, 78, -10, 16, -32, 58, -18, -1, 71, -49, 29, 12, -24, 44, -36, 15, 45, -65, 44, 13, -8, 44, -69, 47, 57, -86, 49, -16, -13, 44, -2, -58, 74, -75, 90, -91, 70, 17, -60, 109, -58, 23, 29, -78, 116, -128, 113, -50, -42, 75, -73, 98, -79, 28, 53, -54, 79, -17, -10, -18, 1, 5, -45, 3, 2, -3, -43, 32, -58);

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

