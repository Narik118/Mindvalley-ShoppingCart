alias Backend.Repo
alias Backend.Schemas.InventorySchema

inventory = [
  %InventorySchema{
    name: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
    price: 109.95,
    quantity: 29,
    status: :available,
    product_image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"
  },
  %InventorySchema{
    name: "Mens Casual Premium Slim Fit T-Shirts",
    description: "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
    price: 22.3,
    quantity: 37,
    status: :available,
    product_image: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg"
  },
  %InventorySchema{
    name: "Mens Cotton Jacket",
    description: "great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions, such as working, hiking, camping, mountain/rock climbing, cycling, traveling or other outdoors. Good gift choice for you or your family member. A warm hearted love to Father, husband or son in this thanksgiving or Christmas Day.",
    price: 55.99,
    quantity: 19,
    status: :available,
    product_image: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg"
  },
  %InventorySchema{
    name: "Mens Casual Slim Fit",
    description: "The color could be slightly different between on the screen and in practice. / Please note that body builds vary by person, therefore, detailed size information should be reviewed below on the product description.",
    price: 15.99,
    quantity: 45,
    status: :available,
    product_image: "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg"
  },
  %InventorySchema{
    name: "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet",
    description: "From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection.",
    price: 695,
    quantity: 28,
    status: :available,
    product_image: "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg"
  },
  %InventorySchema{
    name: "Solid Gold Petite Micropave",
    description: "Satisfaction Guaranteed. Return or exchange any order within 30 days.Designed and sold by Hafeez Center in the United States. Satisfaction Guaranteed. Return or exchange any order within 30 days.",
    price: 168,
    quantity: 20,
    status: :available,
    product_image: "https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg"
  },
  %InventorySchema{
    name: "White Gold Plated Princess",
    description: "Classic Created Wedding Engagement Solitaire Diamond Promise Ring for Her. Gifts to spoil your love more for Engagement, Wedding, Anniversary, Valentine's Day...",
    price: 9.99,
    quantity: 36,
    status: :available,
    product_image: "https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg"
  },
  %InventorySchema{
    name: "Pierced Owl Rose Gold Plated Stainless Steel Double",
    description: "Rose Gold Plated Double Flared Tunnel Plug Earrings. Made of 316L Stainless Steel",
    price: 10.99,
    quantity: 25,
    status: :available,
    product_image: "https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg"
  },
  %InventorySchema{
    name: "WD 2TB Elements Portable External Hard Drive - USB 3.0",
    description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system",
    price: 64,
    quantity: 42,
    status: :available,
    product_image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg"
  },
  %InventorySchema{
    name: "SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s",
    description: "Easy upgrade for faster boot up, shutdown, application load and response (As compared to 5400 RPM SATA 2.5” hard drive; Based on published specifications and internal benchmarking tests using PCMark vantage scores) Boosts burst write performance, making it ideal for typical PC workloads The perfect balance of performance and reliability Read/write speeds of up to 535MB/s/450MB/s (Based on internal testing; Performance may vary depending upon drive capacity, host device, OS and application.)",
    price: 109,
    quantity: 30,
    status: :available,
    product_image: "https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg"
  },
  %InventorySchema{
    name: "Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5",
    description: "3D NAND flash are applied to deliver high transfer speeds Remarkable transfer speeds that enable faster bootup and improved overall system performance. The advanced SLC Cache Technology allows performance boost and longer lifespan 7mm slim design suitable for Ultrabooks and Ultra-slim notebooks. Supports TRIM command, Garbage Collection technology, RAID, and ECC (Error Checking & Correction) to provide the optimized performance and enhanced reliability.",
    price: 109,
    quantity: 27,
    status: :available,
    product_image: "https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg"
  },
  %InventorySchema{
    name: "WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive",
    description: "Expand your PS4 gaming experience, Play anywhere Fast and easy, setup Sleek design with high capacity, 3-year manufacturer's limited warranty",
    price: 114,
    quantity: 33,
    status: :available,
    product_image: "https://fakestoreapi.com/img/61mtL65D4cL._AC_SX679_.jpg"
  },
  %InventorySchema{
    name: "Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin",
    description: "21. 5 inches Full HD (1920 x 1080) widescreen IPS display And Radeon free Sync technology. No compatibility for VESA Mount Refresh Rate: 75Hz - Using HDMI port Zero-frame design | ultra-thin | 4ms response time | IPS panel Aspect ratio - 16: 9. Color Supported - 16. 7 million colors. Brightness - 250 nit Tilt angle -5 degree to 15 degree. Horizontal viewing angle-178 degree. Vertical viewing angle-178 degree 75 hertz",
    price: 599,
    quantity: 19,
    status: :available,
    product_image: "https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg"
  },
  %InventorySchema{
    name: "Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor (LC49HG90DMNXZA) – Super Ultrawide Screen QLED",
    description: "49 INCH SUPER ULTRAWIDE 32:9 CURVED GAMING MONITOR with dual 27 inch screen side by side QUANTUM DOT (QLED) TECHNOLOGY, HDR support and factory calibration provides stunningly realistic and accurate color and contrast 144HZ HIGH REFRESH RATE and 1ms ultra fast response time work to eliminate motion blur, ghosting, and reduce input lag",
    price: 999.99,
    quantity: 22,
    status: :available,
    product_image: "https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg"
  },
  %InventorySchema{
    name: "BIYLACLESEN Women's 3-in-1 Snowboard Jacket Winter Coats",
    description: "Note:The Jackets is US standard size, Please choose size as your usual wear Material: 100% Polyester; Detachable Liner Fabric: Warm Fleece. Detachable Functional Liner: Skin Friendly, Lightweigt and Warm.Stand Collar Liner jacket, keep you warm in cold weather. Zippered Pockets: 2 Zippered Hand Pockets, 1 Zippered Chest Pocket, 1 Internal Pocket, easy to carry personal items. Five pockets: 3 chest pockets and 2 Internal pockets. Removable Hood: Adjustable & Detachable hood, the removable hood is designed for enhanced wind, Keep warm.",
    price: 56.99,
    quantity: 15,
    status: :available,
    product_image: "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg"
  }
]

for product <- inventory do
  Repo.insert!(product)
end
