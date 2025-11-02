// Customizable laptop holder with storage slots

type = 3;			// 0: Nothing on one side, put your own staff
					// 1: Phone holder
					// 2: Storage
					// 3: Another slot for big thing (HDD, typec docker)
					// 4: Nothing

support_height = 85;		// 30, 40, 50, 60, 75, 85, 95, 110, 120, 130
support_distance_x = 25;	// minimal 10, max 50
support_width = 8;			// 3~20
base_width = 100;			// 60~120
base_length = 110;			// 80~150
base_height = 5;			// 5
phone_hold_height = 15;		// 15~30
tri_width = 7;				// 5~20

USB_Base_x = base_width/ 2 + support_distance_x/2 + support_width;
USB_Base_Width = base_width - USB_Base_x;
USB_Base_Length = base_length - 2*tri_width;

echo(USB_Base_Width=USB_Base_Width, 
USB_Base_Length=USB_Base_Length);

// SD positions and counts
SD_Gap_x = 7;
SD_Wall_Gap = 6;
SD_Left_y = tri_width + 7;
SD_Left_x = USB_Base_x + SD_Wall_Gap;
SD_Cnt = 2; //floor(((USB_Base_Width - SD_Wall_Gap)*0.66)/SD_Gap_x);

// FP positions and counts
TF_Gap_x = 7;
TF_Gap_y = 15;
TF_Left_x = 1+ SD_Left_x + (SD_Gap_x) * (SD_Cnt);
TF_Left_y = SD_Left_y;
TF_line_Cnt = 2;//floor((USB_Base_Width - SD_Gap_x * SD_Cnt - SD_Wall_Gap)/TF_Gap_x);

// USB positions and counts
USBA_Gap_y = 10.5;
USBA_Left_y = SD_Left_y + 32;
USBA_Left_x = USB_Base_x + ((base_width - support_distance_x - support_width*2)/2 - 13)/2 - 7;
USBA_Gap_x = 15;
USBA_Cnt = 2;

// Type C positions and counts
TYPEC_Gap_x = 10+0.3;
TYPEC_Gap_y = USBA_Gap_y;
TYPEC_Left_x = USBA_Left_x + 17;
TYPEC_Left_y = USBA_Left_y-1.8;
TYPEC_Cnt = USBA_Cnt;

// Honeycomb para
honeycomb_col = floor((base_length - tri_width*2)/11);
honeycomb_row = floor(support_height - phone_hold_height)/11;
honeycomb_size = 9.5;	// Avoid change
honeycomb_wall = 3.5;	// Avoid change
honeycomb_gap_y = (base_length*0.85 - honeycomb_col * honeycomb_size * 0.66)/2+tri_width;
echo(honeycomb_gap_y=honeycomb_gap_y);

// Other size
required_size = (support_distance_x + support_width * 2);
center_x = base_width / 2;
actual_distance = support_distance_x + support_width;

difference() {
union () {
	first_start_x = center_x - actual_distance / 2 - support_width / 2;
	second_end_x = center_x + actual_distance / 2 + support_width / 2;

// laptop holder
	translate([ center_x - actual_distance / 2 - support_width / 2, 0, base_height ]) color([1, 0, 0]) cube([ support_width, base_length , support_height ]);
	translate([ center_x + actual_distance / 2 - support_width / 2, 0, base_height ]) color([0, 1, 0]) cube([ support_width, base_length , support_height ]);

// base	
	color([0, 0, 1]) cube([base_width, base_length, base_height]);

	if (type == 0)
	{
		echo("Nothing to do");
	}
	
	if (type == 1)
	{
// phone/tab enhance and wall
		color("orange")
	translate([(base_width-support_width-support_distance_x-support_width)/2-phone_hold_height, base_length, -base_height]) rotate([90, 0, 0]) linear_extrude(base_length) 
		{
			polygon([[0, base_height], 
			[phone_hold_height, base_height], 
			[phone_hold_height, phone_hold_height + base_height]]);
		}
		color("orange")
		translate([support_width/2, base_length/2, phone_hold_height/2])
		cube([support_width, base_length, phone_hold_height], center=true);
	}
	
	if (type == 2)
	{
		color("orange")
		translate([support_width/2, base_length/2, support_height/2+base_height])
		cube([support_width, base_length, support_height], center=true);
		
		color("orange")
		translate([USB_Base_Width/2, tri_width/2, support_height/2+base_height])
		cube([USB_Base_Width, tri_width, support_height], center=true);
		color("orange")
		translate([USB_Base_Width/2, base_length-tri_width/2, support_height/2+base_height])
		cube([USB_Base_Width, tri_width, support_height], center=true);
	}
	
	if (type == 3)
	{
		translate([-10, 10, 0])
		draw_honeycombepin(floor(base_length/(honeycomb_size+honeycomb_wall)-1));
		translate([-10 - honeycomb_size, 10, 0])
		draw_honeycombepin(floor(base_length/(honeycomb_size+honeycomb_wall)-1));
		
		color("orange")
		translate([support_width/2, base_length/2, support_height/2+base_height])
		cube([support_width, base_length, support_height], center=true);
		
		color("orange")
		translate([(base_width-support_width-support_distance_x-support_width)/2-phone_hold_height/2-1, base_length, -base_height-1]) rotate([90, 0, 0]) linear_extrude(base_length) 
		{
			polygon([[0, base_height+1], 
			[phone_hold_height/2+1, base_height+1], 
			[phone_hold_height/2+1, phone_hold_height/2+1+base_height+1]]);
		}
		
		
		color("orange")
		translate([phone_hold_height/2+support_width+1, base_length, -base_height-1]) rotate([90, 0, 0])
		linear_extrude(base_length) 
		{
			polygon([[0, base_height+1], 
			[-phone_hold_height/2-1, base_height+1], 
			[-phone_hold_height/2-1, phone_hold_height/2 + base_height + 2]]);
		}
	}
	if (type == 4)
	{
	/*
		color("orange")
		translate([(base_width-support_width-support_distance_x-support_width)/2-phone_hold_height/2-1, base_length, -base_height-1]) rotate([90, 0, 0]) linear_extrude(base_length) 
		{
			polygon([[0, base_height+1], 
			[phone_hold_height/2+1, base_height+1], 
			[phone_hold_height/2+1, phone_hold_height/2+1+base_height+1]]);
		}
	*/
		color("orange")
		translate([USB_Base_Width+phone_hold_height/2+support_width+2, base_length, -base_height-2]) rotate([90, 0, 0])
		linear_extrude(base_length) 
		{
			polygon([[0, base_height+2], 
			[-phone_hold_height/2-2, base_height+2], 
			[-phone_hold_height/2-2, phone_hold_height/2+base_height+4]]);
		}

	}
	

// tri support
	color("yellow")
	translate([0, tri_width, 0]) rotate([90, 0, 0]) linear_extrude(tri_width)
	{
		polygon([[base_width, base_height], 
		[second_end_x, base_height], 
		[second_end_x, support_height + base_height],
		[base_width, base_height+phone_hold_height-base_height]]);
	}
	color("yellow")
	translate([0, base_length , 0]) rotate([90, 0, 0]) linear_extrude(tri_width)
	{
		polygon([[base_width, base_height], 
		[second_end_x, base_height], 
		[second_end_x, support_height + base_height],
		[base_width, base_height+phone_hold_height-base_height]]);
	}

// USB base
	// Corner-based positioning
cube_x = (base_width/2 - support_distance_x/2);
color("pink")
translate([base_width-(base_width-support_distance_x)/4 - 15, base_length/2 - base_length/2, 0])
cube([cube_x, base_length, phone_hold_height]);  
} // End of union

// Dig the hole =============================================

// Honeycomb hole
	scale([1,0.66,1])
	rotate([90, 0, 90])
	if (type != 4)
	{translate([honeycomb_gap_y, phone_hold_height + 7.5, -1])
		honeycomb(honeycomb_size,
		honeycomb_wall,
		honeycomb_row, 
		honeycomb_col,
		100);}
	else
	{translate([honeycomb_gap_y, phone_hold_height + 7.5, base_width/2])
		honeycomb(honeycomb_size,
		honeycomb_wall,
		honeycomb_row, 
		honeycomb_col,
		100);}
	


//SD
	for (pos_SD_x = [SD_Left_x:SD_Gap_x:SD_Left_x+SD_Gap_x*SD_Cnt-1])
		draw_SD(pos_SD_x, SD_Left_y, phone_hold_height);

//TYPE C
	for (pos_TC_y = [TYPEC_Left_y:TYPEC_Gap_y:TYPEC_Left_y+TYPEC_Gap_y*TYPEC_Cnt-1])
	{
		draw_TYPEC(TYPEC_Left_x, pos_TC_y, phone_hold_height);
		draw_TYPEC(TYPEC_Left_x +TYPEC_Gap_x, pos_TC_y, phone_hold_height);
	}

// USB
	// USB (2D grid: X and Y)
  
    for (x = [USBA_Left_x:17:USBA_Left_x+17*USBA_Cnt-1], y = [USBA_Left_y:10.5:USBA_Left_y+10.5*USBA_Cnt-1]) draw_USB(x, y, phone_hold_height);
        
    // Type-C in one line
    for (y = [USBA_Left_y:7:USBA_Left_y + 7* 4]) draw_TYPEC90(USBA_Left_x+ 13, y + 22.5, phone_hold_height);
    
//TF
	for (pos_TYPEC_x = [TF_Left_x:TF_Gap_x:TF_Left_x+TF_Gap_x*TF_line_Cnt-3])
	{
		draw_TF(pos_TYPEC_x, TF_Left_y, phone_hold_height);
		draw_TF(pos_TYPEC_x, TF_Left_y+TF_Gap_y, phone_hold_height);
	}
}

module draw_USB(x, y, z) {
USDA_Width = 13;
USBA_Thick = 5;
USBA_Tall = 13;
translate([x, y, z-USBA_Tall+0.1])
cube([USDA_Width, USBA_Thick, USBA_Tall]);
}

module draw_SD(x, y, z) {
SD_Width = 25.5;
SD_Thick = 3;
SD_Tall = 15;
translate([x, y, z-SD_Tall+0.1])
cube([SD_Thick, SD_Width, SD_Tall]);
}

module draw_TYPEC(x, y, z) {
TYPEC_Width = 9;
TYPEC_Thick = 2.7;
TYPEC_Tall = 8;
translate([x, y, z-TYPEC_Tall+0.1])
cube([TYPEC_Thick, TYPEC_Width, TYPEC_Tall]);
}

module draw_TYPEC90(x, y, z) {
TYPEC_Width = 2.7;
TYPEC_Thick = 9;
TYPEC_Tall = 8;
translate([x, y, z-TYPEC_Tall+0.1])
cube([TYPEC_Thick, TYPEC_Width, TYPEC_Tall]);
}

module draw_TF(x, y, z) {
TF_Width = 13;
TF_Thick = 1.3;
TF_Tall = 10;
translate([x, y, z-TF_Tall+0.1])
cube([TF_Thick, TF_Width, TF_Tall]);
}

module draw_honeycombepin(n)
{
	color("Gold")
	for(pos_y=[0:1:n-1])
	{
	translate([0, pos_y*(honeycomb_size+honeycomb_wall+2),0])
	difference() {
		union(){
			scale([0.66,1,1])
			honeycomb(honeycomb_size-0.25,
			honeycomb_wall+0.25,
			1, 1, (base_width-support_distance_x)/2);
		
			scale([0.66,1,1])
			honeycomb(honeycomb_size+1,
			honeycomb_wall,
			1, 1, 2);
		}
		translate([honeycomb_size/2, -honeycomb_size, -1])
		cube([honeycomb_size, honeycomb_size*2, (base_width-support_distance_x)/2+2]);
		
	}
	}
};

module honeycomb(cellrad, cellthick, rows,cols, cellheight) {
/*
cellrad: quarter inch diameter
cellthick:  wall thickness
rows:
cols:
cellheight:
*/
	cellsize = cellrad-cellthick/2;
	voff = cellsize*1.5;
	hoff = sqrt(pow(cellsize*2,2)-pow(cellsize,2));

    for (i=[0:rows-1])
    {
        even = i % 2 ? cols-1 : cols;
		for (j=[0:even])
        {
			translate([j*hoff+i%2*(hoff/2),i*voff,0])
                rotate([0,0,30])
                    cylinder(r=cellrad-cellthick,h=cellheight,$fn=6);
		}
	}
}

