#[derive(Copy, Drop)]
struct Rectangle {
    width: u64,
    height: u64,
}

#[derive(Copy, Drop)]
struct Cube {
    width: u64,
    height: u64,
    depth: u64,
}

// trait RectangleTrait { // here we define which struct will use the methods --> There is no direct link between a type and a trait. Only the type of the self parameter of a method defines the type from which this method can be called.
//     fn get_area(self: @Rectangle) -> u64;
//     fn get_volume(self: @Cube) -> u64;
// }
#[generate_trait]
impl RectangleImpl of RectangleTrait {
    fn get_area(self: @Rectangle) -> u64 {
        *self.width * *self.height
    }
    fn get_volume(self: @Cube) -> u64 {
        *self.width * *self.height * *self.depth
    }

    fn create_square(size:u64) -> Rectangle {
        Rectangle { width: size , height: size }
    }
}

#[generate_trait]
impl RectangleScalerImpl of RectangleScalerTrait {
    
    fn scale(ref self:Rectangle, factor: u8) {
        self.width = self.width*factor.into();
        self.height = self.height*factor.into();
    }
}

fn main() {
    let mut rect = Rectangle { width: 10, height: 10 };
    let rect_area = get_rectangle_area(rect);
    let rect_area_from_method:u64 = rect.get_area();
    println!("starting area -> {}", rect.get_area());
    rect.scale(2);
    println!("new area -> {}", rect.get_area());
    
    let square = RectangleTrait::create_square(2);
    println!("square area-> {}", square.get_area());

    
    let cube = Cube { width: 10, height: 10, depth:10 };
    let cube_volume_from_method:u64 = cube.get_volume();


    println!("width {} -- height {} -- area {} -- area form method {} cube_volume_from_method {}", rect.width, rect.height, rect_area, rect_area_from_method, cube_volume_from_method);
}


fn get_rectangle_area (rect: Rectangle) -> u64 {
    rect.width * rect.height
}
