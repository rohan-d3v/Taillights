module taillights_turn(input clk, L, R, ERR,BRK, output reg [2:0] TL, TR, output reg [9:0] "LEDR, SW, HEX); 	  

	
	assign "LEDR[9] = TL;
	assign "LEDR[8] = TL;
	assign "LEDR[7] = TL;
	assign "LEDR[0] = TR;
	assign "LEDR[1] = TR;
	assign "LEDR[2] = TR;
	assign CLOCK_50 = clk;
	assign SW[0] = L;
	assign SW[1] = R;
	assign HEX[2] = ERR;
	assign HEX[1] = BRK; 
	
	//pin assignments
	NET "SW[0]" LOC="AB12"
	NET "LEDR[0]" LOC="V16"
	NET "LEDR[1]" LOC="W16"
	NET "LEDR[2]" LOC="V17"

	NET "SW[1]" LOC="AC12" 
	NET "LEDR[7]" LOC="W20"
	NET "LEDR[8]" LOC="W21" 
	NET "LEDR[9]" LOC="Y21" 



	//CLOCK:
	NET "HEX0[3]" LOC="AG27"


	
	always @(posedge clk) begin
		if (1 == ERR) begin		 //Error 
			if (TL == 4'b000 && TR == 4'b000) begin	  //assigns all active low to active high
				TL <= 4'b111;
				TR <= 4'b111;
			end
			else begin	//assigns all active high to active low	once complete
				TL <= 4'b000;
				TR <= 4'b000;
			end
		end	   
		
		if (1 == BRK) begin	  //Brake
			TL <= 4'b000;
			TR <= 4'b000;  
			
			if (TL == 4'b000 && TR == 4'b000) begin	  //assigns all active low to active high
				TL <= 4'b111;
				TR <= 4'b111;
			end
		end

		if (1 == L) begin	   //left turn signal
			TR <= 4'b000;	  //Right signal to active low
			
			
			//Slowly assigns each led to active high using if statements
			if (TL == 4'b000) begin
				TL <= 4'b001;
			end
			if (TL == 4'b001) begin
				TL <= 4'b011;
			end
			if (TL == 4'b011) begin
				TL <= 4'b111;
			end
			
			//assigns back to active low
			else begin
				TL <= 4'b000;
			end
		end									   						   \

		if (1 == R) begin	 //Right Signal
			
			TL <= 4'b000;	 //Assigns Left to active low
			
			//Slowls assigns R to active high using if statements
			if (TR == 4'b000) begin
				TR <= 4'b001;
			end
			else if (TR == 4'b001) begin
				TR <= 4'b011;
			end
			else if (TR == 4'b011) begin
				TR <= 4'b111;
			end
			else begin
				TR <= 4'b000;
			end
		end
		
		//assigns back to active low
		else begin
			TL <= 4'b000;
			TR <= 4'b000;
		end
	end	   
	
endmodule