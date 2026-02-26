library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--16 BIT DECODER--


entity decoder_4_16 is
    port( dec_in:   in std_logic_vector(3 downto 0);
          dec_out:  out std_logic_vector(15 downto 0)
         );     
end decoder_4_16;

architecture rtl of decoder_4_16 is
begin
    with dec_in select
        dec_out <=  "0000000000000001" when "0000",
                    "0000000000000010" when "0001",
                    "0000000000000100" when "0010",
                    "0000000000001000" when "0011",
                    "0000000000010000" when "0100",
                    "0000000000100000" when "0101",
                    "0000000001000000" when "0110",
                    "0000000010000000" when "0111",
                    "0000000100000000" when "1000",
                    "0000001000000000" when "1001",
                    "0000010000000000" when "1010",
                    "0000100000000000" when "1011",
                    "0001000000000000" when "1100",
                    "0010000000000000" when "1101",
                    "0100000000000000" when "1110",
                    "1000000000000000" when "1111",
                    "----------------" when others;
end rtl;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--8 BIT SWITCH--


entity switch_8 is
    port( switch_in:   in std_logic_vector(7 downto 0);
          ctrl: in std_logic;
          switch_out:  out std_logic_vector(7 downto 0)
        );
end switch_8; 

architecture rtl of switch_8 is
begin
    with ctrl select
        switch_out <= switch_in when '1',
                      "00000000" when '0',
                      "--------" when others;   
end rtl;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--1 BIT SWITCH--


entity switch_1 is
    port( switch_in:   in std_logic;
          ctrl: in std_logic;
          switch_out:  out std_logic
        );
end switch_1; 

architecture rtl of switch_1 is
begin
    with ctrl select
        switch_out <= switch_in when '1',
                      '0' when '0',
                      '-' when others;   
end rtl;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--2 INPUT GENERIC MUX--


entity mux_2_1Nbit is
    generic( N: integer);
    port( a, b: in std_logic_vector(N-1 downto 0);
          sel: in std_logic;
          mux_out: out std_logic_vector(N-1 downto 0)
        );
end mux_2_1Nbit;

architecture rtl of mux_2_1Nbit is
begin
    with sel select
        mux_out <= a when '0',
                   b when '1',
                   (others => '-') when others;
end rtl;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--2 SINGLE BIT MUX--


entity mux_2_1bit is
    port( a, b: in std_logic;
          sel: in std_logic;
          mux_out: out std_logic
        );
end mux_2_1bit;

architecture rtl of mux_2_1bit is
begin
    with sel select
        mux_out <= a when '0',
                   b when '1',
                   '-' when others;
end rtl;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--18 BIT GENERIC SHIFTER--


entity shifter_18_Npos is
    generic( N: integer);
    port( shift_in: in std_logic_vector(17 downto 0);
          shift_out: out std_logic_vector(17 downto 0)
        );
end shifter_18_Npos;

architecture rtl of shifter_18_Npos is

begin
    shift_out(0) <= shift_in(0 + N) when N < 18 else shift_in(17);
    shift_out(1) <= shift_in(1 + N) when N < 17 else shift_in(17);
    shift_out(2) <= shift_in(2 + N) when N < 16 else shift_in(17);
    shift_out(3) <= shift_in(3 + N) when N < 15 else shift_in(17);
    shift_out(4) <= shift_in(4 + N) when N < 14 else shift_in(17);
    shift_out(5) <= shift_in(5 + N) when N < 13 else shift_in(17);
    shift_out(6) <= shift_in(6 + N) when N < 12 else shift_in(17);
    shift_out(7) <= shift_in(7 + N) when N < 11 else shift_in(17);
    shift_out(8) <= shift_in(8 + N) when N < 10 else shift_in(17);
    shift_out(9) <= shift_in(9 + N) when N < 9 else shift_in(17);
    shift_out(10) <= shift_in(10 + N) when N < 8 else shift_in(17);
    shift_out(11) <= shift_in(11 + N) when N < 7 else shift_in(17);
    shift_out(12) <= shift_in(12 + N) when N < 6 else shift_in(17);
    shift_out(13) <= shift_in(13 + N) when N < 5 else shift_in(17);
    shift_out(14) <= shift_in(14 + N) when N < 4 else shift_in(17);
    shift_out(15) <= shift_in(15 + N) when N < 3 else shift_in(17);
    shift_out(16) <= shift_in(16 + N) when N < 2 else shift_in(17);
end rtl;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.ALL;
use IEEE.std_logic_arith.ALL;


--8 BIT TRONCATOR-


entity troncator is
    port( tronc_in: in std_logic_vector(15 downto 0);
          tronc_out: out std_logic_vector(7 downto 0)
        );
end troncator;

architecture rtl of troncator is
begin
    tronc_out <= "10000000" when tronc_in < -128 else
                 "01111111" when tronc_in > 127 else
                 tronc_in(7 downto 0);
end rtl;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;


--16 BIT COMPARATOR--


entity comparator is
    port( comp_in1, comp_in2 : in std_logic_vector(15 downto 0);
          comp_out : out std_logic
        );
end comparator;

architecture rtl of comparator is
begin
    comp_out <= '1' when comp_in1 > comp_in2 else '0';
end rtl;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--D FLIP FLOP CON RESET ASINCRONO--


entity D_FF is
    port( CLK, RESET, D: in std_logic;
          Q: out std_logic
        );
end D_FF;

architecture rtl of D_FF is
begin
    process(CLK, RESET)
    begin
        if(RESET = '1') then
            Q <= '0';
        elsif rising_edge(CLK) then
            Q <= D;
        end if;
    end process;
end rtl;

        
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
                    

--REGISTRO PARALLELO-PARALLELO GENRICO CON RESET ASINCRONO--


entity registro is
    generic( N: integer);
    port( reg_in: in std_logic_vector(N - 1 downto 0);
          CLK, RESET: in std_logic;
          reg_out: out std_logic_vector(N - 1 downto 0)
        );
end registro;

architecture rtl of registro is
begin
    process(CLK, RESET)
    begin
        if(RESET = '1') then
            reg_out <= (others => '0');
        elsif rising_edge(CLK) then
            reg_out <= reg_in;
        end if;
    end process;
end rtl;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;


--CONTATORE MODULO 2^N (generico) CON RESET ASINCRONO--


entity counter_N_bit is
    generic( N: integer);
    port( CLK, RESET: in std_logic;
          count_out: out std_logic_vector(N - 1 downto 0)
        );
end counter_N_bit;

architecture rtl of counter_N_bit is
    signal s: std_logic_vector(N - 1 downto 0);
begin
    process(CLK, RESET)
    begin
        if(RESET = '1') then
            s <= (others => '0');
        elsif rising_edge(CLK) then
            s <= s + "1"; 
        end if;
    end process;
    count_out <= s;
end rtl;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.ALL;
use IEEE.std_logic_arith.ALL;   


--MODULO NORMATORE--
     

entity normator is
    port( normator_in: in std_logic_vector(17 downto 0);
          filter_type: in std_logic;
          normator_out: out std_logic_vector(15 downto 0)
        );
end normator;

architecture mixed of normator is


component shifter_18_Npos is
    generic( N: integer);
    port( shift_in: in std_logic_vector(17 downto 0);
          shift_out: out std_logic_vector(17 downto 0)
        );
end component;

component mux_2_1Nbit is
    generic( N: integer);
    port( a, b: in std_logic_vector(N-1 downto 0);
          sel: in std_logic;
          mux_out: out std_logic_vector(N-1 downto 0)
        );
end component;

signal s0, s1, s2, s3: std_logic_vector(17 downto 0);
signal s4, s5, s6, s7, s8, s9, s10: std_logic_vector(15 downto 0);

begin
    
    bitsh_4: shifter_18_Npos
        generic map(4)
        port map(shift_in => normator_in,shift_out => s0);
    bitsh_6: shifter_18_Npos
        generic map(6)
        port map(shift_in => normator_in,shift_out => s1);
    bitsh_8: shifter_18_Npos
        generic map(8)
        port map(shift_in => normator_in,shift_out => s2);
    bitsh_10: shifter_18_Npos
        generic map(10)
        port map(shift_in => normator_in,shift_out =>  s3);
    mux_sel: mux_2_1Nbit
        generic map(16)
        port map(a => "0000000000000000",b => "0000000000000001", sel => normator_in(17), mux_out => s4);
    
    s5 <= s0(15 downto 0) + s4;
    s6 <= s1(15 downto 0) + s4;
    s7 <= s2(15 downto 0) + s4;
    s8 <= s3(15 downto 0) + s4;
    s9 <= s5 + s6 + s7 + s8;
    s10 <= s6 + s8;
    
    mux_fin: mux_2_1Nbit
        generic map(16)
        port map(a => s9, b=> s10, sel => filter_type, mux_out => normator_out);
end mixed;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--INPUT SELECTION COMPONENT 1--


entity input_sel_comp_1 is
    port( i_clk, i_rst, i_start, clear, end_setup : in std_logic;
          i_mem_data : in std_logic_vector(7 downto 0);
          k1, k2, coeff0, coeff1, coeff2, coeff3, coeff4, coeff5, coeff6 : out std_logic_vector(7 downto 0);
          end_setup_out, filter: out std_logic;
          save_bus : out std_logic_vector(9 downto 0);
          counter_val: out std_logic_vector(3 downto 0)
        );
end input_sel_comp_1;

architecture mixed of input_sel_comp_1 is

component counter_N_bit is
    generic( N: integer);
    port( CLK, RESET: in std_logic;
          count_out: out std_logic_vector(N - 1 downto 0)
        );
end component;

component decoder_4_16 is
    port( dec_in:   in std_logic_vector(3 downto 0);
          dec_out:  out std_logic_vector(15 downto 0)
         );     
end component;

component switch_8 is
    port( switch_in:   in std_logic_vector(7 downto 0);
          ctrl: in std_logic;
          switch_out:  out std_logic_vector(7 downto 0)
        );
end component; 

component switch_1 is
    port( switch_in:   in std_logic;
          ctrl: in std_logic;
          switch_out:  out std_logic
        );
end component; 

signal dec_out_temp: std_logic_vector(15 downto 0);
signal internal_dec_out : std_logic_vector(11 downto 0);
signal internal_clk, internal_rst : std_logic;
signal internal_counter_val : std_logic_vector(3 downto 0);
signal swc_control0, swc_control1, swc_control2, swc_control3, swc_control4, swc_control5, swc_control6, swc_control7, swc_control8, swc_control9: std_logic;

begin

internal_clk <= i_clk and i_start;
internal_rst <= clear or i_rst;

    counter_to_16: counter_N_bit
        generic map(4)
        port map(CLK => internal_clk, RESET => internal_rst, count_out => internal_counter_val);
        
    decoder: decoder_4_16
        port map(dec_in => internal_counter_val, dec_out => dec_out_temp);
    
    internal_dec_out <= dec_out_temp(12 downto 1);
    swc_control0 <= internal_dec_out(0) and not(end_setup);
    swc_control1 <= internal_dec_out(1) and not(end_setup);
    swc_control2 <= internal_dec_out(2) and not(end_setup);
    swc_control3 <= internal_dec_out(3) and not(end_setup);
    swc_control4 <= internal_dec_out(4) and not(end_setup);
    swc_control5 <= internal_dec_out(5) and not(end_setup);
    swc_control6 <= internal_dec_out(6) and not(end_setup);
    swc_control7 <= internal_dec_out(7) and not(end_setup);
    swc_control8 <= internal_dec_out(8) and not(end_setup);
    swc_control9 <= internal_dec_out(9) and not(end_setup); 
    
    swc0 : switch_8
        port map(switch_in => i_mem_data, ctrl => swc_control0, switch_out => k1);
        
    swc1 : switch_8
        port map(switch_in => i_mem_data, ctrl => swc_control1, switch_out => k2);
    
    swc2 : switch_1
        port map(switch_in => i_mem_data(0), ctrl => swc_control2, switch_out => filter);
    
    swc3 : switch_8
        port map(switch_in => i_mem_data, ctrl => swc_control3, switch_out => coeff0);
    
    swc4 : switch_8
        port map(switch_in => i_mem_data, ctrl => swc_control4, switch_out => coeff1);
    
    swc5 : switch_8
        port map(switch_in => i_mem_data, ctrl => swc_control5, switch_out => coeff2);
    
    swc6 : switch_8
        port map(switch_in => i_mem_data, ctrl => swc_control6, switch_out => coeff3);
    
    swc7 : switch_8
        port map(switch_in => i_mem_data, ctrl => swc_control7, switch_out => coeff4);
    
    swc8 : switch_8
        port map(switch_in => i_mem_data, ctrl => swc_control8, switch_out => coeff5);
    
    swc9 : switch_8
        port map(switch_in => i_mem_data, ctrl => swc_control9, switch_out => coeff6);
        
    end_setup_out <= internal_dec_out(10);
    
    
    save_bus <= swc_control9 & swc_control8 & swc_control7 & swc_control6 & swc_control5 & swc_control4 & swc_control3 & swc_control2 & swc_control1 & swc_control0;
        
    counter_val <= internal_counter_val;
    
end mixed;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;  


--INTERNAL MEMORY COMPONENT 1--


entity internal_memory_component_1 is
    port( i_clk, clear, i_rst, end_setup_in, filter : in std_logic;
          counter_val : in std_logic_vector(3 downto 0);
          k1, k2, coeff0, coeff1, coeff2, coeff3, coeff4, coeff5, coeff6 : in std_logic_vector(7 downto 0);
          i_add : in std_logic_vector(15 downto 0);
          save_bus : in std_logic_vector(9 downto 0);
          end_setup_out, s: out std_logic;
          word_number, o_mem_addr : out std_logic_vector(15 downto 0);
          coeff0_out, coeff1_out, coeff2_out, coeff3_out, coeff4_out, coeff5_out, coeff6_out : out std_logic_vector(7 downto 0)
        );
        
end internal_memory_component_1;

architecture mixed of internal_memory_component_1 is

component D_FF is
    port( CLK, RESET, D: in std_logic;
          Q: out std_logic
        );
end component;
          
component registro is
    generic( N: integer);
    port( reg_in: in std_logic_vector(N - 1 downto 0);
          CLK, RESET: in std_logic;
          reg_out: out std_logic_vector(N - 1 downto 0)
        );
end component;

component mux_2_1Nbit is
    generic( N: integer);
    port( a, b: in std_logic_vector(N-1 downto 0);
          sel: in std_logic;
          mux_out: out std_logic_vector(N-1 downto 0)
        );
end component;

signal mux_ctrl, FF_clk_signal, internal_rst, end_setup_loop, FF_filter_out: std_logic;
signal internal_clk_bus: std_logic_vector(9 downto 0);
signal temp_k1, temp_k2: std_logic_vector(7 downto 0);
signal coeff_selector, mux_val, k1k2_in: std_logic_vector(15 downto 0);

begin
    
    internal_clk_bus <= save_bus and (i_clk & i_clk & i_clk & i_clk & i_clk & i_clk & i_clk & i_clk & i_clk & i_clk);
    internal_rst <= clear or i_rst;
    FF_clk_signal <= not(end_setup_loop) and i_clk;
    
    --Definizione dei FF
    
    FF_filter: D_FF
        port map(CLK => internal_clk_bus(2), RESET => internal_rst, D => filter, Q => FF_filter_out);
        
    FF_end_setup : D_FF
        port map(CLK => FF_clk_signal, RESET => internal_rst, D => end_setup_in, Q => end_setup_loop);
        
    --Definizione dei registri
    
    reg_k1: registro
        generic map(8)
        port map(reg_in => k1, CLK => internal_clk_bus(0), RESET => internal_rst, reg_out => temp_k1);
     
    reg_k2: registro
        generic map(8)
        port map(reg_in => k2, CLK => internal_clk_bus(1), RESET => internal_rst, reg_out => temp_k2);
        
    k1k2_in <= temp_k1 & temp_k2;
    
    reg_k1k2: registro
        generic map(16)
        port map(reg_in => k1k2_in, CLK => internal_clk_bus(2), RESET => internal_rst, reg_out => word_number);
    
    reg_c0: registro
        generic map(8)
        port map(reg_in => coeff0, CLK => internal_clk_bus(3), RESET => internal_rst, reg_out => coeff0_out);
        
     reg_c1: registro
        generic map(8)
        port map(reg_in => coeff1, CLK => internal_clk_bus(4), RESET => internal_rst, reg_out => coeff1_out);
     
     reg_c2: registro
        generic map(8)
        port map(reg_in => coeff2, CLK => internal_clk_bus(5), RESET => internal_rst, reg_out => coeff2_out);
     
     reg_c3: registro
        generic map(8)
        port map(reg_in => coeff3, CLK => internal_clk_bus(6), RESET => internal_rst, reg_out => coeff3_out);
     
     
     reg_c4: registro
        generic map(8)
        port map(reg_in => coeff4, CLK => internal_clk_bus(7), RESET => internal_rst, reg_out => coeff4_out);
        
     reg_c5: registro
        generic map(8)
        port map(reg_in => coeff5, CLK => internal_clk_bus(8), RESET => internal_rst, reg_out => coeff5_out);
     
     reg_c6: registro
        generic map(8)
        port map(reg_in => coeff6, CLK => internal_clk_bus(9), RESET => internal_rst, reg_out => coeff6_out);
        
     mux_ctrl <= FF_filter_out or filter;
     
     mux: mux_2_1Nbit
        generic map(16)
        port map(a => (others => '0'), b => "0000000000000111", sel => mux_ctrl, mux_out => coeff_selector);
        
     o_mem_addr <= i_add + coeff_selector + counter_val;
     s <= mux_ctrl;
     end_setup_out <= end_setup_loop;

end mixed;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--SETUP COMPONENT--


entity setup_component is
    port( i_clk, i_start, i_rst, clear : in std_logic;
          i_mem_data : in std_logic_vector(7 downto 0);
          i_add : in std_logic_vector(15 downto 0);
          end_setup, s, addr_selection: out std_logic;
          word_number, o_mem_addr: out std_logic_vector(15 downto 0);
          c0, c1, c2, c3, c4, c5, c6: out std_logic_vector(7 downto 0)
        );
end setup_component;

architecture structural of setup_component is

component input_sel_comp_1 is
    port( i_clk, i_rst, i_start, clear, end_setup : in std_logic;
          i_mem_data : in std_logic_vector(7 downto 0);
          k1, k2, coeff0, coeff1, coeff2, coeff3, coeff4, coeff5, coeff6 : out std_logic_vector(7 downto 0);
          end_setup_out, filter: out std_logic;
          save_bus : out std_logic_vector(9 downto 0);
          counter_val: out std_logic_vector(3 downto 0)
        );
end component;

component internal_memory_component_1 is
    port( i_clk, clear, i_rst, end_setup_in, filter : in std_logic;
          counter_val : in std_logic_vector(3 downto 0);
          k1, k2, coeff0, coeff1, coeff2, coeff3, coeff4, coeff5, coeff6 : in std_logic_vector(7 downto 0);
          i_add : in std_logic_vector(15 downto 0);
          save_bus : in std_logic_vector(9 downto 0);
          end_setup_out, s: out std_logic;
          word_number, o_mem_addr : out std_logic_vector(15 downto 0);
          coeff0_out, coeff1_out, coeff2_out, coeff3_out, coeff4_out, coeff5_out, coeff6_out : out std_logic_vector(7 downto 0)
        );
        
end component;

signal count_val_sig: std_logic_vector(3 downto 0);
signal save_sig: std_logic_vector(9 downto 0);
signal k1_sig, k2_sig, coeff0_sig, coeff1_sig, coeff2_sig, coeff3_sig, coeff4_sig, coeff5_sig, coeff6_sig: std_logic_vector(7 downto 0);
signal end_setup_sig, end_setup_out, filter_sig: std_logic;

begin
    
    input_selection: input_sel_comp_1
        port map(i_clk => i_clk, i_rst => i_rst, i_start => i_start, clear => clear, end_setup => end_setup_out,
                 i_mem_data => i_mem_data, k1 => k1_sig, k2 => k2_sig, filter => filter_sig, coeff0 => coeff0_sig, 
                 coeff1 => coeff1_sig, coeff2 => coeff2_sig, coeff3 => coeff3_sig, coeff4 => coeff4_sig, coeff5 => coeff5_sig,
                 coeff6 => coeff6_sig, end_setup_out => end_setup_sig, save_bus => save_sig, 
                 counter_val => count_val_sig);
    
    elab_information: internal_memory_component_1
        port map(i_clk => i_clk, clear => clear, i_rst => i_rst, end_setup_in => end_setup_sig, counter_val => count_val_sig,
                 k1 => k1_sig, k2 => k2_sig, filter => filter_sig, coeff0 => coeff0_sig, coeff1 => coeff1_sig, coeff2 => coeff2_sig,
                 coeff3 => coeff3_sig, coeff4 => coeff4_sig, coeff5 => coeff5_sig, coeff6 => coeff6_sig, i_add => i_add,
                 save_bus => save_sig, end_setup_out => end_setup_out, s => s, word_number => word_number, o_mem_addr => o_mem_addr,
                 coeff0_out => c0, coeff1_out => c1, coeff2_out => c2, coeff3_out => c3, coeff4_out => c4, coeff5_out => c5, 
                 coeff6_out => c6);
        
        addr_selection <= end_setup_sig;         
        
        end_setup <= end_setup_out;

end structural;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;  


--TERMINE DEL PRIMO MACROBLOCCO


--WORD COUNTER COMPONENT--


entity word_counter_component is
    port( i_rst, clear, s, i_clk, cont_rst: in std_logic;
          i_add, word_number: in std_logic_vector(15 downto 0);
          write_addr, starting_coeff_addr, count_val: out std_logic_vector(15 downto 0)
        );
end word_counter_component;

architecture mixed of word_counter_component is

component counter_N_bit is
    generic( N: integer);
    port( CLK, RESET: in std_logic;
          count_out: out std_logic_vector(N - 1 downto 0)
        );
end component;


component mux_2_1Nbit is
    generic( N: integer);
    port( a, b: in std_logic_vector(N-1 downto 0);
          sel: in std_logic;
          mux_out: out std_logic_vector(N-1 downto 0)
        );
end component;

signal mux_out, sum, starting_filtered_word_addr, count_out_sig: std_logic_vector(15 downto 0);
signal internal_clk, internal_rst: std_logic;

begin

    internal_rst <= i_rst or clear;
    internal_clk <= i_clk and cont_rst;
    
    
    mux: mux_2_1Nbit
        generic map(16)
        port map(a => "0000000000001111",b => "0000000000001110", sel => s, mux_out => mux_out);
    
    sum <= i_add + mux_out;
    
    cont_2_power16: counter_N_bit
        generic map(16)
        port map(CLK => internal_clk, RESET => internal_rst, count_out => count_out_sig);
    
    starting_coeff_addr <= sum + count_out_sig;
    
    starting_filtered_word_addr <= word_number + "0000000000010001" + i_add;
    write_addr <= starting_filtered_word_addr + count_out_sig;
    
    count_val <= count_out_sig;

end mixed;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 


--COMMAND CONTROLLER--


entity command_controller is
    port( word_number, count_val: in std_logic_vector(15 downto 0);
          i_start: in std_logic;
          clear, o_mem_en, o_done: out std_logic
        );
end command_controller;

architecture mixed of command_controller is

component comparator is
    port( comp_in1, comp_in2 : in std_logic_vector(15 downto 0);
          comp_out : out std_logic
        );
end component;

signal comp_out, o_done_sig: std_logic;

begin
    
    comp: comparator
        port map(comp_in1 => count_val, comp_in2 => word_number, comp_out => comp_out);
    
    o_done_sig <= i_start and comp_out;
    
    o_done <= o_done_sig;
    o_mem_en <= not(i_start) nor o_done_sig;
    clear <= not(i_start);

end mixed;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;  


--INPUT SELECTION COMPONENT 2--


entity input_selection_component2 is
    port( i_clk, i_rst, clear, s, end_setup: in std_logic;
          write_addr, starting_coeff: in std_logic_vector(15 downto 0);
          o_mem_we, cont_rst: out std_logic;
          sel_bus0: out std_logic_vector(4 downto 0);
          sel_bus1: out std_logic_vector(6 downto 0);
          comp_val, o_mem_addr: out std_logic_vector(15 downto 0)
        );
end input_selection_component2;

architecture mixed of input_selection_component2 is

component mux_2_1bit is
    port( a, b: in std_logic;
          sel: in std_logic;
          mux_out: out std_logic
        );
end component;

component decoder_4_16 is
    port( dec_in:   in std_logic_vector(3 downto 0);
          dec_out:  out std_logic_vector(15 downto 0)
         );     
end component;

component mux_2_1Nbit is
    generic( N: integer);
    port( a, b: in std_logic_vector(N-1 downto 0);
          sel: in std_logic;
          mux_out: out std_logic_vector(N-1 downto 0)
        );
end component;

component counter_N_bit is
    generic( N: integer);
    port( CLK, RESET: in std_logic;
          count_out: out std_logic_vector(N - 1 downto 0)
        );
end component;

signal read_addr, dec_out_temp0, dec_out_temp1: std_logic_vector(15 downto 0);
signal internal_clk, internal_rst_counter0, internal_rst_counter1, mux_we_sig: std_logic;
signal write_en_sig0, write_en_sig1, counter0_rst_sig, counter1_rst_sig: std_logic;
signal counter_val0, counter_val1, mux_count_sig: std_logic_vector(3 downto 0);

begin
    
    internal_clk <= i_clk and end_setup;
    internal_rst_counter0 <= i_rst or clear or counter0_rst_sig;
    internal_rst_counter1 <= i_rst or clear or counter1_rst_sig;
    read_addr <= starting_coeff + mux_count_sig;
    
    counter0: counter_N_bit
        generic map(4)
        port map(CLK => internal_clk, RESET => internal_rst_counter0, count_out => counter_val0);
    
    counter1: counter_N_bit                                                                      
        generic map(4)                                                                           
        port map(CLK => internal_clk, RESET => internal_rst_counter1, count_out => counter_val1);
        
    dec0: decoder_4_16
        port map(dec_in => counter_val0, dec_out => dec_out_temp0);
    
    dec1: decoder_4_16
        port map(dec_in => counter_val1, dec_out => dec_out_temp1);
    
   
    
    sel_bus0 <= dec_out_temp0(5 downto 1);
    sel_bus1 <= dec_out_temp1(7 downto 1);
    
    write_en_sig0 <= dec_out_temp0(6);
    counter0_rst_sig <= dec_out_temp0(7);
    
    write_en_sig1 <= dec_out_temp1(8);
    counter1_rst_sig <= dec_out_temp1(9);
    
    mux_we: mux_2_1bit
        port map(a => write_en_sig0, b => write_en_sig1, sel => s, mux_out => mux_we_sig);
        
    
    mux_counter: mux_2_1Nbit
        generic map(4)
        port map(a => counter_val0, b => counter_val1, sel => s, mux_out => mux_count_sig);
    
    mux_mem_addr: mux_2_1Nbit
        generic map(16)
        port map(a => read_addr, b => write_addr, sel => mux_we_sig, mux_out => o_mem_addr);
        
    mux_cont_rst: mux_2_1bit
        port map(a => counter0_rst_sig, b => counter1_rst_sig, sel => s, mux_out => cont_rst);
    
    o_mem_we <= mux_we_sig;
    comp_val <= read_addr;

end mixed;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;  


--COMPARATOR COMPONENT--


entity comparator_component is
    port( i_add, comp_val, word_number: in std_logic_vector(15 downto 0);
          i_clk, i_rst, end_setup, clear: in std_logic;
          sel0, sel1: out std_logic
        );
end comparator_component;

architecture mixed of comparator_component is

component comparator is
    port( comp_in1, comp_in2 : in std_logic_vector(15 downto 0);
          comp_out : out std_logic
        );
end component;
        
component registro is
    generic( N: integer);
    port( reg_in: in std_logic_vector(N - 1 downto 0);
          CLK, RESET: in std_logic;
          reg_out: out std_logic_vector(N - 1 downto 0)
        );
end component;

signal start_addr, end_addr, current_addr: std_logic_vector(15 downto 0);
signal internal_clk, internal_rst: std_logic;

begin
    
    start_addr <= i_add + "0000000000010001";
    end_addr <= i_add + word_number + "0000000000010000";
    internal_clk <= i_clk and end_setup;
    internal_rst <= i_rst or clear;
    
    curr_addr_reg: registro
        generic map(16)
        port map(reg_in => comp_val, CLK => internal_clk, RESET => internal_rst, reg_out => current_addr);
        
    comp_start: comparator
        port map(comp_in1 => start_addr, comp_in2 => current_addr, comp_out => sel0);
    
    comp_end: comparator
        port map(comp_in1 => current_addr, comp_in2 => end_addr, comp_out => sel1);
        
end mixed;


--TERMINE SECONDO MACROBLOCCO


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--ELABORATION CONTROL COMPONENT--


entity elaboration_control_component is
    port( word_number, i_add: in std_logic_vector(15 downto 0);
          i_clk, i_rst, i_start, s, end_setup: in std_logic;
          clear, o_done, o_mem_we, o_mem_en, sel1, sel0: out std_logic;
          sel_bus0: out std_logic_vector(4 downto 0);
          sel_bus1: out std_logic_vector(6 downto 0);
          o_mem_addr: out std_logic_vector(15 downto 0)
        );
end elaboration_control_component;

architecture structural of elaboration_control_component is

component word_counter_component is
    port( i_rst, clear, s, i_clk, cont_rst: in std_logic;
          i_add, word_number: in std_logic_vector(15 downto 0);
          write_addr, starting_coeff_addr, count_val: out std_logic_vector(15 downto 0)
        );
end component;

component command_controller is
    port( word_number, count_val: in std_logic_vector(15 downto 0);
          i_start: in std_logic;
          clear, o_mem_en, o_done: out std_logic
        );
end component;

component input_selection_component2 is
    port( i_clk, i_rst, clear, s, end_setup: in std_logic;
          write_addr, starting_coeff: in std_logic_vector(15 downto 0);
          o_mem_we, cont_rst: out std_logic;
          sel_bus0: out std_logic_vector(4 downto 0);
          sel_bus1: out std_logic_vector(6 downto 0);
          comp_val, o_mem_addr: out std_logic_vector(15 downto 0)
        );
end component;

component comparator_component is
    port( i_add, comp_val, word_number: in std_logic_vector(15 downto 0);
          i_clk, i_rst, end_setup, clear: in std_logic;
          sel0, sel1: out std_logic
        );
end component;

signal count_val, write_addr, starting_coeff, comp_val: std_logic_vector(15 downto 0);
signal clear_sig, cont_rst_sig: std_logic;

begin

    clear <= clear_sig;
    
    main_counter: word_counter_component
        port map( i_rst => i_rst, clear => clear_sig, 
                  s => s, i_add => i_add, word_number => word_number, i_clk => i_clk,
                  write_addr => write_addr, starting_coeff_addr => starting_coeff,
                  count_val => count_val, cont_rst => cont_rst_sig);
                 
    controller: command_controller
        port map( word_number => word_number, count_val => count_val, i_start => i_start, 
                  clear => clear_sig, o_mem_en => o_mem_en, o_done => o_done); 
        
    selection: input_selection_component2
        port map( i_clk => i_clk, i_rst => i_rst, clear => clear_sig, s => s, 
                  end_setup => end_setup, write_addr => write_addr, starting_coeff => starting_coeff, 
                  o_mem_we => o_mem_we, sel_bus0 => sel_bus0, 
                  sel_bus1 => sel_bus1, comp_val => comp_val, o_mem_addr => o_mem_addr, cont_rst => cont_rst_sig);
    
    comparator_selection: comparator_component
        port map( i_add => i_add, comp_val => comp_val, word_number => word_number, i_clk => i_clk,
                  i_rst => i_rst, end_setup => end_setup, clear => clear_sig, sel0 => sel0, sel1 => sel1);
        
end structural;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--SELECTION ELABORATION COMPONENT--


entity selection_elaboration_component is
    port( i_mem_data: in std_logic_vector(7 downto 0);
          sel0, sel1, i_clk, s: in std_logic;
          sel_bus0: in std_logic_vector(4 downto 0);
          sel_bus1: in std_logic_vector(6 downto 0);
          save_bus: out std_logic_vector(6 downto 0);
          val0, val1, val2, val3, val4, val5, val6: out std_logic_vector(7 downto 0)
        );
end selection_elaboration_component;

architecture mixed of selection_elaboration_component is

component mux_2_1Nbit is
    generic( N: integer);
    port( a, b: in std_logic_vector(N-1 downto 0);
          sel: in std_logic;
          mux_out: out std_logic_vector(N-1 downto 0)
        );
end component;
        
component switch_8 is
    port( switch_in:   in std_logic_vector(7 downto 0);
          ctrl: in std_logic;
          switch_out:  out std_logic_vector(7 downto 0)
        );
end component; 

component mux_2_1bit is
    port( a, b: in std_logic;
          sel: in std_logic;
          mux_out: out std_logic
        );
end component;

signal mux_val_0, mux_val_1, mux_val_2, mux_val_4, mux_val_5, mux_val_6: std_logic_vector(7 downto 0);
signal switch_val_0, switch_val_6, switch_val_1_0, switch_val_1_1, switch_val_2_0, switch_val_2_1: std_logic_vector(7 downto 0);
signal switch_val_3_0, switch_val_3_1, switch_val_4_0, switch_val_4_1, switch_val_5_0, switch_val_5_1: std_logic_vector(7 downto 0);
signal control_1, control_2, control_3, control_4, control_5: std_logic;
signal save_bus_el0, save_bus_el1, save_bus_el2, save_bus_el3, save_bus_el4, save_bus_el5, save_bus_el6: std_logic;


begin

    --FIRST LAYER MUX
    
    first_layer_mux0: mux_2_1Nbit
        generic map(8)
        port map(a => i_mem_data, b => "00000000", sel => sel0, mux_out => mux_val_0);
    
    first_layer_mux1: mux_2_1Nbit
        generic map(8)
        port map(a => i_mem_data, b => "00000000", sel => sel0, mux_out => mux_val_1);
        
    first_layer_mux2: mux_2_1Nbit
        generic map(8)
        port map(a => i_mem_data, b => "00000000", sel => sel0, mux_out => mux_val_2);
        
    first_layer_mux4: mux_2_1Nbit
        generic map(8)
        port map(a => i_mem_data, b => "00000000", sel => sel1, mux_out => mux_val_4);
        
    first_layer_mux5: mux_2_1Nbit
        generic map(8)
        port map(a => i_mem_data, b => "00000000", sel => sel1, mux_out => mux_val_5);
        
    first_layer_mux6: mux_2_1Nbit
        generic map(8)
        port map(a => i_mem_data, b => "00000000", sel => sel1, mux_out => mux_val_6);
        
    --FIRST LAYER SWITCH
        
    first_layer_switch1: switch_8
        port map(switch_in => mux_val_1, ctrl => sel_bus0(0), switch_out => switch_val_1_0);
        
    first_layer_switch2: switch_8
        port map(switch_in => mux_val_2, ctrl => sel_bus0(1), switch_out => switch_val_2_0);
        
    first_layer_switch3: switch_8
        port map(switch_in => i_mem_data, ctrl => sel_bus0(2), switch_out => switch_val_3_0);
     
    first_layer_switch4: switch_8
        port map(switch_in => mux_val_4, ctrl => sel_bus0(3), switch_out => switch_val_4_0);
        
    first_layer_switch5: switch_8
        port map(switch_in => mux_val_5, ctrl => sel_bus0(4), switch_out => switch_val_5_0);
     
    --SECOND LAYER SWITCH
    
    second_layer_switch0: switch_8
        port map(switch_in => mux_val_0, ctrl => sel_bus1(0), switch_out => switch_val_0);
    
    second_layer_switch1: switch_8
        port map(switch_in => mux_val_1, ctrl => sel_bus1(1), switch_out => switch_val_1_1);
    
    second_layer_switch2: switch_8
        port map(switch_in => mux_val_2, ctrl => sel_bus1(2), switch_out => switch_val_2_1);
    
    second_layer_switch3: switch_8
        port map(switch_in => i_mem_data, ctrl => sel_bus1(3), switch_out => switch_val_3_1);
    
    second_layer_switch4: switch_8
        port map(switch_in => mux_val_4, ctrl => sel_bus1(4), switch_out => switch_val_4_1);
    
    second_layer_switch5: switch_8
        port map(switch_in => mux_val_5, ctrl => sel_bus1(5), switch_out => switch_val_5_1);
        
    second_layer_switch6: switch_8
        port map(switch_in => mux_val_6, ctrl => sel_bus1(6), switch_out => switch_val_6);
        
    --CONTROL MUX LAYER
    
    
    control_mux_1: mux_2_1bit
        port map(a => sel_bus0(0), b => sel_bus1(1), sel => s, mux_out => control_1);
    
    control_mux_2: mux_2_1bit
        port map(a => sel_bus0(1), b => sel_bus1(2), sel => s, mux_out => control_2);
    
    control_mux_3: mux_2_1bit
        port map(a => sel_bus0(2), b => sel_bus1(3), sel => s, mux_out => control_3);
    
    control_mux_4: mux_2_1bit
        port map(a => sel_bus0(3), b => sel_bus1(4), sel => s, mux_out => control_4);
        
    control_mux_5: mux_2_1bit
        port map(a => sel_bus0(4), b => sel_bus1(5), sel => s, mux_out => control_5);
    
    --SECOND MUX LAYER
    
    second_layer_mux0: mux_2_1Nbit
        generic map(8)
        port map(a => "00000000", b => switch_val_0, sel => s, mux_out => val0);
    
    second_layer_mux1: mux_2_1Nbit
        generic map(8)
        port map(a => switch_val_1_0, b => switch_val_1_1, sel => s, mux_out => val1);
    
    second_layer_mux2: mux_2_1Nbit
        generic map(8)
        port map(a => switch_val_2_0, b => switch_val_2_1, sel => s, mux_out => val2);
    
    second_layer_mux3: mux_2_1Nbit
        generic map(8)
        port map(a => switch_val_3_0, b => switch_val_3_1, sel => s, mux_out => val3);
    
    second_layer_mux4: mux_2_1Nbit
        generic map(8)
        port map(a => switch_val_4_0, b => switch_val_4_1, sel => s, mux_out => val4);
        
    second_layer_mux5: mux_2_1Nbit
        generic map(8)
        port map(a => switch_val_5_0, b => switch_val_5_1, sel => s, mux_out => val5);
    
    second_layer_mux6: mux_2_1Nbit
        generic map(8)
        port map(a => "00000000", b => switch_val_6, sel => s, mux_out => val6);  
    
    --CREATION OF SAVE BUS
    
    save_bus_el0 <= sel_bus1(0);
    save_bus_el1 <= control_1;
    save_bus_el2 <= control_2;
    save_bus_el3 <= control_3;
    save_bus_el4 <= control_4;
    save_bus_el5 <= control_5;
    save_bus_el6 <= sel_bus1(6);
    
    
    --processo che assegna ai singoli bit del save_bus i loro valori. 
    --il processo e' stato introdotto perche' avevo dei problemi con il post sintesi.
    --la sua introduzione ha risolto il problema.
    
    process (i_clk)
    begin  
        if rising_edge(i_clk) then
            if s = '1' then
                save_bus <= "0000000";
                save_bus(0) <= save_bus_el0;
                save_bus(1) <= save_bus_el1;
                save_bus(2) <= save_bus_el2;
                save_bus(3) <= save_bus_el3;
                save_bus(4) <= save_bus_el4;
                save_bus(5) <= save_bus_el5;
                save_bus(6) <= save_bus_el6;
            else
                save_bus <= "0000000";
                save_bus(1) <= save_bus_el1;
                save_bus(2) <= save_bus_el2;
                save_bus(3) <= save_bus_el3;
                save_bus(4) <= save_bus_el4;
                save_bus(5) <= save_bus_el5;
            end if;
        end if;
    end process;
    
end mixed;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.ALL;
use IEEE.std_logic_arith.ALL;  


--MULTIPLICATION COMPONENT--


entity multiplication_component is
    port( i_rst, clear: std_logic;
          val0, val1, val2, val3, val4, val5, val6: in std_logic_vector(7 downto 0);
          coeff0, coeff1, coeff2, coeff3, coeff4, coeff5, coeff6: in std_logic_vector(7 downto 0);
          save_bus: in std_logic_vector(6 downto 0);
          reg_out0, reg_out1, reg_out2, reg_out3, reg_out4, reg_out5, reg_out6: out std_logic_vector(15 downto 0)
        );
end multiplication_component;

architecture mixed of multiplication_component is

component registro is
    generic( N: integer);
    port( reg_in: in std_logic_vector(N - 1 downto 0);
          CLK, RESET: in std_logic;
          reg_out: out std_logic_vector(N - 1 downto 0)
        );
end component;

signal ris0, ris1, ris2, ris3, ris4, ris5, ris6: std_logic_vector(15 downto 0);
signal internal_rst: std_logic;

begin
    
    ris0 <= val0 * coeff0;
    ris1 <= val1 * coeff1;
    ris2 <= val2 * coeff2;
    ris3 <= val3 * coeff3;
    ris4 <= val4 * coeff4;
    ris5 <= val5 * coeff5;
    ris6 <= val6 * coeff6;
    
    internal_rst <= i_rst or clear;
    
    reg0: registro
        generic map(16)
        port map(reg_in => ris0, CLK => save_bus(0), RESET => internal_rst, reg_out => reg_out0);
    
    reg1: registro                                                                             
        generic map(16)                                                                          
        port map(reg_in => ris1, CLK => save_bus(1), RESET => internal_rst, reg_out => reg_out1);
    
    reg2: registro                                                                             
        generic map(16)                                                                          
        port map(reg_in => ris2, CLK => save_bus(2), RESET => internal_rst, reg_out => reg_out2);
    
    reg3: registro                                                                           
        generic map(16)                                                                          
        port map(reg_in => ris3, CLK => save_bus(3), RESET => internal_rst, reg_out => reg_out3);
    
    reg4: registro                                                                              
        generic map(16)                                                                          
        port map(reg_in => ris4, CLK => save_bus(4), RESET => internal_rst, reg_out => reg_out4);
    
    reg5: registro                                                                            
        generic map(16)                                                                          
        port map(reg_in => ris5, CLK => save_bus(5), RESET => internal_rst, reg_out => reg_out5);
    
    reg6: registro                                                                             
        generic map(16)                                                                          
        port map(reg_in => ris6, CLK => save_bus(6), RESET => internal_rst, reg_out => reg_out6);
        
end mixed;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.ALL;
use IEEE.std_logic_arith.ALL;  


--FINAL CALCULATION COMPONENT--


entity final_calculation_component is
    port( val_0, val_1, val_2, val_3, val_4, val_5, val_6: in std_logic_vector(15 downto 0);
          s: in std_logic;
          o_mem_data: out std_logic_vector(7 downto 0)
        );
end final_calculation_component;

architecture mixed of final_calculation_component is

component normator is
    port( normator_in: in std_logic_vector(17 downto 0);
          filter_type: in std_logic;
          normator_out: out std_logic_vector(15 downto 0)
        );
end component;

component troncator is
    port( tronc_in: in std_logic_vector(15 downto 0);
          tronc_out: out std_logic_vector(7 downto 0)
        );
end component;

signal normator_in: std_logic_vector(17 downto 0);
signal normator_out: std_logic_vector(15 downto 0);
signal val_temp0, val_temp1, val_temp2, val_temp3, val_temp4, val_temp5, val_temp6: std_logic_vector(17 downto 0);

begin

    --Espandere i valori a 18 bit.

    val_temp0 <= ("00" & val_0) when val_0 >= 0 else ("11" & val_0) when val_0 < 0 else "000000000000000000";
    val_temp1 <= ("00" & val_1) when val_1 >= 0 else ("11" & val_1) when val_1 < 0 else "000000000000000000";
    val_temp2 <= ("00" & val_2) when val_2 >= 0 else ("11" & val_2) when val_2 < 0 else "000000000000000000";
    val_temp3 <= ("00" & val_3) when val_3 >= 0 else ("11" & val_3) when val_3 < 0 else "000000000000000000";
    val_temp4 <= ("00" & val_4) when val_4 >= 0 else ("11" & val_4) when val_4 < 0 else "000000000000000000";
    val_temp5 <= ("00" & val_5) when val_5 >= 0 else ("11" & val_5) when val_5 < 0 else "000000000000000000";
    val_temp6 <= ("00" & val_6) when val_6 >= 0 else ("11" & val_6) when val_6 < 0 else "000000000000000000";
    
    normator_in <= val_temp0 + val_temp1 + val_temp2 + val_temp3 + val_temp4 + val_temp5 + val_temp6;
    
    normatore: normator
        port map(normator_in => normator_in, filter_type => s, normator_out => normator_out);
    
    troncatore: troncator
        port map(tronc_in => normator_out, tronc_out => o_mem_data);

end mixed;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--ELABORATION COMPONENT--


entity elaboration_component is
    port( s, i_rst, i_clk, clear, sel0, sel1: in std_logic;
          i_mem_data, coeff0, coeff1, coeff2, coeff3, coeff4, coeff5, coeff6: in std_logic_vector(7 downto 0);
          sel_bus_0: in std_logic_vector(4 downto 0);
          sel_bus_1: in std_logic_vector(6 downto 0);
          o_mem_data: out std_logic_vector(7 downto 0)
        );
end elaboration_component;

architecture structural of elaboration_component is

component selection_elaboration_component is
    port( i_mem_data: in std_logic_vector(7 downto 0);
          sel0, sel1, i_clk, s: in std_logic;
          sel_bus0: in std_logic_vector(4 downto 0);
          sel_bus1: in std_logic_vector(6 downto 0);
          save_bus: out std_logic_vector(6 downto 0);
          val0, val1, val2, val3, val4, val5, val6: out std_logic_vector(7 downto 0)
        );
end component;

component multiplication_component is
    port( i_rst, clear: std_logic;
          val0, val1, val2, val3, val4, val5, val6: in std_logic_vector(7 downto 0);
          coeff0, coeff1, coeff2, coeff3, coeff4, coeff5, coeff6: in std_logic_vector(7 downto 0);
          save_bus: in std_logic_vector(6 downto 0);
          reg_out0, reg_out1, reg_out2, reg_out3, reg_out4, reg_out5, reg_out6: out std_logic_vector(15 downto 0)
        );
end component;

component final_calculation_component is
    port( val_0, val_1, val_2, val_3, val_4, val_5, val_6: in std_logic_vector(15 downto 0);
          s: in std_logic;
          o_mem_data: out std_logic_vector(7 downto 0)
        );
end component;

signal save_bus_sig: std_logic_vector(6 downto 0);
signal val0_sig, val1_sig, val2_sig, val3_sig, val4_sig, val5_sig, val6_sig: std_logic_vector(7 downto 0);
signal reg_out0_sig, reg_out1_sig, reg_out2_sig, reg_out3_sig, reg_out4_sig, reg_out5_sig, reg_out6_sig: std_logic_vector(15 downto 0);

begin
    
    selection: selection_elaboration_component
        port map(i_mem_data => i_mem_data, sel0 => sel0, sel1 => sel1, i_clk => i_clk, s => s, sel_bus0 => sel_bus_0,
                 sel_bus1 => sel_bus_1, save_bus => save_bus_sig, val0 => val0_sig, val1 => val1_sig, val2 => val2_sig,
                 val3 => val3_sig, val4 => val4_sig, val5 => val5_sig, val6 => val6_sig);

    multiplication: multiplication_component
        port map(i_rst => i_rst, clear => clear, val0 => val0_sig, val1 => val1_sig, val2 => val2_sig, val3 => val3_sig,
                 val4 => val4_sig, val5 => val5_sig, val6 => val6_sig, coeff0 => coeff0, coeff1 => coeff1,
                 coeff2 => coeff2, coeff3 => coeff3, coeff4 => coeff4, coeff5 => coeff5, coeff6 => coeff6,
                 save_bus => save_bus_sig, reg_out0 => reg_out0_sig, reg_out1 => reg_out1_sig, reg_out2 => reg_out2_sig,
                 reg_out3 => reg_out3_sig, reg_out4 => reg_out4_sig, reg_out5 => reg_out5_sig, reg_out6 => reg_out6_sig);
     
    final_calulation: final_calculation_component
        port map(val_0 => reg_out0_sig, val_1 => reg_out1_sig, val_2 => reg_out2_sig, val_3 => reg_out3_sig, 
                 val_4 => reg_out4_sig, val_5 => reg_out5_sig, val_6 => reg_out6_sig, s => s, o_mem_data => o_mem_data); 

end structural;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--PROGETTO--

entity project_reti_logiche is
    port(       i_clk : in std_logic;
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
end project_reti_logiche;

architecture mixed of project_reti_logiche is

component setup_component is
    port( i_clk, i_start, i_rst, clear : in std_logic;
          i_mem_data : in std_logic_vector(7 downto 0);
          i_add : in std_logic_vector(15 downto 0);
          end_setup, s, addr_selection: out std_logic;
          word_number, o_mem_addr: out std_logic_vector(15 downto 0);
          c0, c1, c2, c3, c4, c5, c6: out std_logic_vector(7 downto 0)
        );
end component;

component elaboration_control_component is
    port( word_number, i_add: in std_logic_vector(15 downto 0);
          i_clk, i_rst, i_start, s, end_setup: in std_logic;
          clear, o_done, o_mem_we, o_mem_en, sel1, sel0: out std_logic;
          sel_bus0: out std_logic_vector(4 downto 0);
          sel_bus1: out std_logic_vector(6 downto 0);
          o_mem_addr: out std_logic_vector(15 downto 0)
        );
end component;

component elaboration_component is
    port( s, i_rst, i_clk, clear, sel0, sel1: in std_logic;
          i_mem_data, coeff0, coeff1, coeff2, coeff3, coeff4, coeff5, coeff6: in std_logic_vector(7 downto 0);
          sel_bus_0: in std_logic_vector(4 downto 0);
          sel_bus_1: in std_logic_vector(6 downto 0);
          o_mem_data: out std_logic_vector(7 downto 0)
        );
end component;

component mux_2_1Nbit is
    generic( N: integer);
    port( a, b: in std_logic_vector(N-1 downto 0);
          sel: in std_logic;
          mux_out: out std_logic_vector(N-1 downto 0)
        );
end component;

signal c0, c1, c2, c3, c4, c5, c6: std_logic_vector(7 downto 0);
signal word_number_sig, o_mem_addr_setup, o_mem_addr_elab: std_logic_vector(15 downto 0);
signal sel0_sig, sel1_sig, s_sig, end_setup_sig, clear_sig, addr_selection_sig, mux_sig: std_logic;
signal sel_bus0_sig: std_logic_vector(4 downto 0);
signal sel_bus1_sig: std_logic_vector(6 downto 0);

begin
    
    setup: setup_component
        port map(i_clk => i_clk, i_rst => i_rst, i_start => i_start, clear => clear_sig, i_mem_data => i_mem_data,
                 i_add => i_add, end_setup => end_setup_sig, addr_selection => addr_selection_sig, s => s_sig, 
                 word_number => word_number_sig, o_mem_addr => o_mem_addr_setup, c0 => c0, c1 => c1,
                 c2 => c2, c3 => c3, c4 => c4, c5 => c5, c6 => c6);
    
    elaboration_control: elaboration_control_component
        port map(word_number => word_number_sig, i_add => i_add, i_clk => i_clk, i_rst => i_rst, i_start => i_start,
                 s => s_sig, end_setup => end_setup_sig, clear => clear_sig, o_done => o_done, o_mem_we => o_mem_we, 
                 o_mem_en => o_mem_en, sel0 => sel0_sig, sel1 => sel1_sig, sel_bus0 => sel_bus0_sig, 
                 sel_bus1 => sel_bus1_sig, o_mem_addr => o_mem_addr_elab);
    
    
    elaboration_comp: elaboration_component
        port map(s => s_sig, i_rst => i_rst, i_clk => i_clk, clear => clear_sig, sel0 => sel0_sig, sel1 => sel1_sig, 
                 i_mem_data => i_mem_data, coeff0 => c0, coeff1 => c1, coeff2 => c2, coeff3 => c3, coeff4 => c4, 
                 coeff5 => c5, coeff6 => c6, sel_bus_0 => sel_bus0_sig, sel_bus_1 => sel_bus1_sig, o_mem_data => o_mem_data);
    
    mux_sig <= addr_selection_sig or end_setup_sig;             
    
    addr_selector: mux_2_1Nbit
        generic map(16)
        port map(a => o_mem_addr_setup, b => o_mem_addr_elab, sel => mux_sig, mux_out => o_mem_addr);

end mixed;