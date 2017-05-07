//
//  InitializeItemData.swift
//  
//
//  Created by Finn on 4/25/17.
//
//

import Foundation

func initializeItemData() -> [Item] {
    
    var itemsList = [Item]()
    
    // 1
    itemsList.append(Item(name: "Phillipe's", number: 1, item: "French Dip Sandwich", visited: false, coords: ["34.059768,-118.237035"], isMobile: false))
    
    // 2
    itemsList.append(Item(name: "Sycamore Kitchen", number: 2, item: "Mediterranean Gem Salad", visited: false, coords: ["34.0723653,-118.344421"], isMobile: false))
    
    // 3
    itemsList.append(Item(name: "Golden Deli", number: 3, item: "Pho", visited: false, coords: ["34.1028567,-118.1117593"], isMobile: false))
    
    // 4
    itemsList.append(Item(name: "Greenblatt's Deli", number: 4, item: "Chicken Noodle Soup", visited: false, coords: ["34.0981571,-118.3646505"], isMobile: false))

    // 5
    itemsList.append(Item(name: "Diddy Reese", number: 5, item: "Ice Cream Sandwich", visited: false, coords: ["34.0630585,-118.446859"], isMobile: false))
    
    // 6
    itemsList.append(Item(name: "Urth Caffe", number: 6, item: "Green Tea Matcha Latte", visited: false, coords: ["34.004361,-118.485779","34.0626573,-118.3994193","34.082145,-118.378931","34.04197,-118.235422","34.0667305,-118.3900266","33.544219,-117.788384","34.14551,-118.138124"], isMobile: false))
    
    // 7
    itemsList.append(Item(name: "Dodger Stadium", number: 7, item: "Dodger Dog", visited: false, coords: ["34.073851,-118.2399583"], isMobile: false))

    // 8 - this location list is known to be too short
    itemsList.append(Item(name: "Alfred Coffee", number: 8, item: "Edible Espresso Cup", visited: false, coords: ["34.0833724,-118.3743114","34.082046,-118.37707"], isMobile: false))

    // 9 
    itemsList.append(Item(name: "Bottega Louie", number: 9, item: "Macaron", visited: false, coords: ["34.0469536,-118.2564831"], isMobile: false))

    // 10 
    itemsList.append(Item(name: "The Donut Man", number: 10, item: "Seasonal Strawberry Donut", visited: false, coords: ["34.1289705,-117.8497678"], isMobile: false))
    
    // 11
    itemsList.append(Item(name: "In-N-Out", number: 11, item: "Animal Style Fries", visited: false, coords: ["34.063064,-118.448026","34.0264684,-118.3942793","33.9537063,-118.396763","34.1350731,-118.3606042","33.945794,-118.33238"], isMobile: false))

    // 12
    itemsList.append(Item(name: "Pink's", number: 12, item: "Classic Chili Cheese Dog", visited: false, coords: ["34.0838725,-118.3442778"], isMobile: false))
    
    // 13
    itemsList.append(Item(name: "Guerilla Tacos", number: 13, item: "Sweet Potato Tacos", visited: false, coords: ["34.045701,-118.235316","34.0310922,-118.3778603"], isMobile: true))
    
    // 14
    itemsList.append(Item(name: "Father's Office", number: 14, item: "The Office Burger", visited: false, coords: ["34.029318,-118.498368","34.0304038,-118.3848082"], isMobile: false))
    
    // 15
    itemsList.append(Item(name: "Mariscos Jalisco", number: 15, item: "Shrimp Tacos", visited: false, coords: ["34.0209537,-118.2128456"], isMobile: false))
    
    // 16
    itemsList.append(Item(name: "Kogi", number: 16, item: "Short Rib Tacos", visited: false, coords: ["34.0245124,-118.4112034"], isMobile: true))
    
    // 17
    itemsList.append(Item(name: "El Tepeyac Cafe", number: 17, item: "The Hollenbeck Burrito", visited: false, coords: ["34.047738,-118.197579"], isMobile: false))
    
    // 18
    itemsList.append(Item(name: "Wurstkuche", number: 18, item: "The Rattlesnake and Rabbit Bratwurst", visited: false, coords: ["33.9997405,-118.4649579","34.045601,-118.236064"], isMobile: false))
    
    // 19
    itemsList.append(Item(name: "Langer's Deli", number: 19, item: "The Original #19", visited: false, coords: ["34.0561767,-118.2767998"], isMobile: false))
    
    // 20
    itemsList.append(Item(name: "Eggslut", number: 20, item: "The Fairfax", visited: false, coords: ["33.9873748,-118.4722263","34.0506538,-118.2486981"], isMobile: false))
    
    // 21
    itemsList.append(Item(name: "Yogurt Stop", number: 21, item: "Red Velvet Froyo", visited: false, coords: ["34.085861,-118.383084"], isMobile: false))
    
    // 22
    itemsList.append(Item(name: "Streets of LA", number: 22, item: "Bacon Wrapped Street Dog", visited: false, coords: ["34.0522342,-118.2436849"], isMobile: true))
    
    // 23
    itemsList.append(Item(name: "Cacao Mexicatessen", number: 23, item: "Mexican Hot Chocolate", visited: false, coords: ["34.1392684,-118.200662"], isMobile: false))
    
    // 24
    itemsList.append(Item(name: "Sushi Gen", number: 24, item: "Chirashi Lunch Special", visited: false, coords: ["34.046703,-118.2387686"], isMobile: false))
    
    // 25
    itemsList.append(Item(name: "Plan Check", number: 25, item: "Sweet Potato Fries", visited: false, coords: ["34.0439004,-118.4459537","34.0776525,-118.361609","34.0141185,-118.4974821","34.0525983,-118.2634476"], isMobile: false))
    
    // 26
    itemsList.append(Item(name: "Stella Barra", number: 26, item: "Rice Krispy Treat Cookies", visited: false, coords: ["34.0977183,-118.3286804"], isMobile: false))
    
    // 27
    itemsList.append(Item(name: "Canter's Deli", number: 27, item: "Matzo Ball Soup", visited: false, coords: ["34.0789,-118.361722"], isMobile: false))
    
    // 28
    itemsList.append(Item(name: "CVT Softserve", number: 28, item: "Twist Cone", visited: false, coords: ["34.1068751,-118.2718642"], isMobile: true))
    
    // 29
    itemsList.append(Item(name: "Chart House", number: 29, item: "Chocolate Lava Cake", visited: false, coords: ["33.9786922,-118.4533319","33.851704,-118.398844"], isMobile: false))
    
    // 30
    itemsList.append(Item(name: "Roscoe's Chicken and Waffles", number: 30, item: "The #9", visited: false, coords: ["34.0475288,-118.3462124","34.0985783,-118.3221555","33.9598486,-118.2745223","33.9618174,-118.3674194","33.7953116,-117.9147345","34.1602128,-118.1321805"], isMobile: false))
    
    // 31
    itemsList.append(Item(name: "The Apple Pan", number: 31, item: "Banana Crème Pie", visited: false, coords: ["34.0406956,-118.4278467"], isMobile: false))
    
    // 32
    itemsList.append(Item(name: "Canter's Deli", number: 32, item: "Pastrami Sandwich", visited: false, coords: ["34.0789,-118.361722"], isMobile: false))
    
    // 33
    itemsList.append(Item(name: "Vito's", number: 33, item: "White Pizza with Ricotta and Pesto", visited: false, coords: ["34.086588,-118.3760066","34.0326434,-118.475521"], isMobile: false))
    
    // 34
    itemsList.append(Item(name: "Jon and Vinny's", number: 34, item: "The LA Woman Pizza", visited: false, coords: ["34.0786517,-118.3612248"], isMobile: false))
    
    // 35
    itemsList.append(Item(name: "El Compadre", number: 35, item: "The Flaming Margarita", visited: false, coords: ["34.0978073,-118.3522447"], isMobile: false))
    
    // 36
    itemsList.append(Item(name: "La Estrella", number: 36, item: "Carne Tacos", visited: false, coords: ["34.0903333,-118.3832903"], isMobile: false))
    
    // 37
    itemsList.append(Item(name: "Chego", number: 37, item: "Chubby Pork Belly Bowl ", visited: false, coords: ["34.0613819,-118.2396111"], isMobile: false))
    
    // 38
    itemsList.append(Item(name: "Pizzaria Mozza", number: 38, item: "Butterscotch Budino", visited: false, coords: ["34.0831213,-118.3388633"], isMobile: false))
    
    // 39
    itemsList.append(Item(name: "The Pantry", number: 39, item: "The Ten Pound Pancakes", visited: false, coords: ["34.0463704,-118.2629158"], isMobile: false))
    
    // 40
    itemsList.append(Item(name: "Bob's Coffee and Donuts", number: 40, item: "Plain Cake Donut", visited: false, coords: ["34.0720269,-118.3598175"], isMobile: false))
    
    // 41
    itemsList.append(Item(name: "Bay Cities Italian Deli", number: 41, item: "Spicy Godmother", visited: false, coords: ["34.0178598,-118.4892024"], isMobile: false))
    
    // 42
    itemsList.append(Item(name: "Soot Bull Jeep", number: 42, item: "Galbi", visited: false, coords: ["34.0575858,-118.2958153"], isMobile: false))
    
    // 43
    itemsList.append(Item(name: "Din Tai Fung", number: 43, item: "Soup Dumplings", visited: false, coords: ["34.1429849,-118.2553442","34.1350798,-118.0517164","33.6920939,-117.8877851"], isMobile: false))
    
    // 44
    itemsList.append(Item(name: "Zankou Chicken", number: 44, item: "Tarna Warp", visited: false, coords: ["34.0471585,-118.4437234","34.0982898,-118.3606741","34.0985315,-118.3002893"], isMobile: false))
    
    // 45
    itemsList.append(Item(name: "The Bigg Chill", number: 45, item: "Vegan Cookie Dough", visited: false, coords: ["34.0437144,-118.4313531"], isMobile: false))
    
    // 46
    itemsList.append(Item(name: "Porto's", number: 46, item: "Guave Cheese Pastry", visited: false, coords: ["34.1676971,-118.3465324","34.1504211,-118.2554535"], isMobile: false))
    
    // 47
    itemsList.append(Item(name: "La Scala", number: 47, item: "Original Chopped Salad", visited: false, coords: ["34.0529574,-118.4668351"], isMobile: false))
    
    // 48
    itemsList.append(Item(name: "Falafel Arax", number: 48, item: "Chicken Shawarma Baguette Sandwich", visited: false, coords: ["34.091054,-118.300799"], isMobile: false))
    
    // 49
    itemsList.append(Item(name: "sugarfish", number: 49, item: "Trust Me", visited: false, coords: ["34.0535179,-118.463145","34.0734652,-118.3442974","34.047409,-118.257171","34.0682208,-118.3982564","34.0982981,-118.3226969","33.978918,-118.437878","34.0153935,-118.4972314","34.140301,-118.3755543"], isMobile: false))
    
    // 50
    itemsList.append(Item(name: "Bestia", number: 50, item: "Charcuterie Board", visited: false, coords: ["34.0336655,-118.2292632"], isMobile: false))
    
    // 51
    itemsList.append(Item(name: "Musso and Frank Grill", number: 51, item: "Martini", visited: false, coords: ["34.1018304,-118.3354084"], isMobile: false))
    
    // 52
    itemsList.append(Item(name: "Sqirl", number: 52, item: "Crispy Rice Salad", visited: false, coords: ["34.0842999,-118.286684"], isMobile: false))
    
    // 53
    itemsList.append(Item(name: "Sotto", number: 53, item: "Guanciale Pizza", visited: false, coords: ["34.0554217,-118.3976085"], isMobile: false))
    
    // 54
    itemsList.append(Item(name: "Umami Burger", number: 54, item: "The Umami Burger", visited: false, coords: ["34.016691,-118.49213","34.073067,-118.358497","34.0989281,-118.3292468","34.0424672,-118.2556542","34.0455554,-118.2367412","34.100696,-118.290505","33.942257,-118.407042"], isMobile: false))
    
    // 55
    itemsList.append(Item(name: "Yang Chow", number: 55, item: "Slippery Shrimp", visited: false, coords: ["34.0629657,-118.2382179"], isMobile: false))
    
    // 56
    itemsList.append(Item(name: "Cofax", number: 56, item: "Pastrami Breakfast Burrito", visited: false, coords: ["34.079336,-118.361266"], isMobile: false))
    
    // 57
    itemsList.append(Item(name: "Ricky's Fish Tacos", number: 57, item: "Fish Tacos", visited: false, coords: ["34.0968815,-118.2872444"], isMobile: true))
    
    // 58
    itemsList.append(Item(name: "Katsu-Ya", number: 58, item: "Spicy Tuna Crispy Rice", visited: false, coords: ["34.1408027,-118.3874229","34.1576319,-118.4938785","34.1834562,-118.6051396","34.2464432,-118.5370186"], isMobile: false))
    
    // 59
    itemsList.append(Item(name: "Providence", number: 59, item: "The Ugly Bunch", visited: false, coords: ["34.0836413,-118.3302036"], isMobile: false))
    
    // 60
    itemsList.append(Item(name: "Pizzaria Mozza", number: 60, item: "Fennel Sausage Pizza", visited: false, coords: ["34.0831213,-118.3388633"], isMobile: false))
    
    // 61
    itemsList.append(Item(name: "The Dal Rae", number: 61, item: "Table-side Caesar", visited: false, coords: ["33.9829117,-118.0961274"], isMobile: false))
    
    // 62
    itemsList.append(Item(name: "Dan Tana's", number: 62, item: "Chicken Parm", visited: false, coords: ["34.0817517,-118.3890223"], isMobile: false))
    
    // 63
    itemsList.append(Item(name: "El Cholo", number: 63, item: "Nachos", visited: false, coords: ["34.0243913,-118.4920785","34.050257,-118.3092343","34.0435993,-118.2638228","33.9456196,-118.4038455"], isMobile: false))
    
    // 64
    itemsList.append(Item(name: "Casa Bianca Pizza Pie", number: 64, item: "Pepperoni Pizza", visited: false, coords: ["34.139198,-118.2028302"], isMobile: false))
    
    // 65
    itemsList.append(Item(name: "Eagle Rock Italian Bakery", number: 65, item: "Rum Cake", visited: false, coords: ["34.1392187,-118.2046433"], isMobile: false))
    
    // 66
    itemsList.append(Item(name: "Chaya", number: 66, item: "Tuna Tartare", visited: false, coords: ["34.0512948,-118.2575046"], isMobile: false))
    
    // 67
    itemsList.append(Item(name: "Crossroads Kitchen", number: 67, item: "Artichoke Oysters", visited: false, coords: ["34.083527,-118.370157"], isMobile: false))
    
    // 68
    itemsList.append(Item(name: "Valerie Confections", number: 68, item: "Blum's Coffee Crunch Cake", visited: false, coords: ["34.0733807,-118.2860371"], isMobile: false))
    
    // 69
    itemsList.append(Item(name: "Original Pancake House", number: 69, item: "Dutch Baby Pancake", visited: false, coords: ["33.8179892,-118.381627","33.6740935,-117.9528023","33.838927,-117.89813","33.940221,-117.981051"], isMobile: false))
    
    // 70
    itemsList.append(Item(name: "Pann's", number: 70, item: "Fried Chicken", visited: false, coords: ["33.9781832,-118.3706077"], isMobile: false))
    
    // 71
    itemsList.append(Item(name: "Atticus Creamery and Pies", number: 71, item: "Lemon Lavender Ice Cream", visited: false, coords: ["34.0399404,-118.4294921"], isMobile: false))
    
    // 72
    itemsList.append(Item(name: "Bob's Big Boy", number: 72, item: "Big Boy Combo", visited: false, coords: ["34.2315838,-118.5618725","34.1523958,-118.3461425"], isMobile: false))
    
    // 73
    itemsList.append(Item(name: "Miceli's", number: 73, item: "Aunt Angie's Lasagna", visited: false, coords: ["34.10134,-118.336097","34.134631,-118.361089"], isMobile: false))
    
    // 74
    itemsList.append(Item(name: "Milo and Olive", number: 74, item: "Garlic Knot", visited: false, coords: ["34.0375206,-118.4760501"], isMobile: false))
    
    // 75
    itemsList.append(Item(name: "Animal", number: 75, item: "Bacon Chocolate Crunch Bar", visited: false, coords: ["34.0792295,-118.3617722"], isMobile: false))
    
    // 76
    itemsList.append(Item(name: "Baroo", number: 76, item: "Noorook", visited: false, coords: ["34.0904444,-118.3138278"], isMobile: false))
    
    // 77
    itemsList.append(Item(name: "Petit Trois", number: 77, item: "French Omelette", visited: false, coords: ["34.0841763,-118.3381923"], isMobile: false))
    
    // 78
    itemsList.append(Item(name: "Gjusta", number: 78, item: "Porchetta Melt", visited: false, coords: ["33.9952738,-118.4745361"], isMobile: false))
    
    // 79
    itemsList.append(Item(name: "Chi Spacca", number: 79, item: "Focaccia di Recco", visited: false, coords: ["34.0832643,-118.3390895"], isMobile: false))
    
    // 80
    itemsList.append(Item(name: "Melisse", number: 80, item: "Lobster Bolognese", visited: false, coords: ["34.0242934,-118.4912758"], isMobile: false))
    
    // 81
    itemsList.append(Item(name: "Jogosaki", number: 81, item: "Sushi Burrito ", visited: false, coords: ["34.0205202,-118.4221912"], isMobile: true))
    
    // 82
    itemsList.append(Item(name: "Lawry's", number: 82, item: "Prime Rib", visited: false, coords: ["34.067832,-118.376023"], isMobile: false))
    
    // 83
    itemsList.append(Item(name: "South Beverly Grill", number: 83, item: "Dover Sole", visited: false, coords: ["34.066125,-118.3989013"], isMobile: false))
    
    // 84
    itemsList.append(Item(name: "The Polo Lounge", number: 84, item: "McCarthy Salad", visited: false, coords: ["34.081528,-118.413855"], isMobile: false))
    
    // 85
    itemsList.append(Item(name: "Angelini Osteria", number: 85, item: "Green Lasagna", visited: false, coords: ["34.0764256,-118.3491328"], isMobile: false))
    
    // 86
    itemsList.append(Item(name: "Ago", number: 86, item: "Osso Buco", visited: false, coords: ["34.0821725,-118.3756588"], isMobile: false))
    
    // 87
    itemsList.append(Item(name: "Musso and Frank Grill", number: 87, item: "Flannel Cakes", visited: false, coords: ["34.1018304,-118.3354084"], isMobile: false))
    
    // 88
    itemsList.append(Item(name: "El Cholo", number: 88, item: "Green corn tamales", visited: false, coords: ["34.0243913,-118.4920785","34.050257,-118.3092343","34.0435993,-118.2638228","33.9456196,-118.4038455"], isMobile: false))
    
    // 89
    itemsList.append(Item(name: "Craig's", number: 89, item: "Honey Truffle Chicken", visited: false, coords: ["34.0806196,-118.3865179"], isMobile: false))
    
    // 90
    itemsList.append(Item(name: "The Apple Pan", number: 90, item: "Hickory Burger", visited: false, coords: ["34.0406956,-118.4278467"], isMobile: false))
    
    // 91
    itemsList.append(Item(name: "Magnolia Bakery", number: 91, item: "Banana Bread Pudding", visited: false, coords: ["34.073116,-118.3730101"], isMobile: false))
    
    // 92
    itemsList.append(Item(name: "Osteria Mozza", number: 92, item: "Burrata", visited: false, coords: ["34.0832515,-118.338874"], isMobile: false))
    
    // 93
    itemsList.append(Item(name: "Caioti", number: 93, item: "Pregnancy Salad", visited: false, coords: ["34.149073,-118.3788193"], isMobile: false))
    
    // 94
    itemsList.append(Item(name: "Casa Bianca Pizza Pie", number: 94, item: "Fried Eggplant Pizza", visited: false, coords: ["34.139198,-118.2028302"], isMobile: false))
    
    // 95
    itemsList.append(Item(name: "Magal Korean BBQ", number: 95, item: "Beef Combo", visited: false, coords: ["34.0575419,-118.3055724"], isMobile: false))
    
    // 96
    itemsList.append(Item(name: "Pacific Dining Car", number: 96, item: "Baseball Steak (w/lobster tail)", visited: false, coords: ["34.0367387,-118.4763373","34.0554918,-118.2660331"], isMobile: false))
    
    // 97
    itemsList.append(Item(name: "Spago", number: 97, item: "Smoked Salmon Pizza", visited: false, coords: ["34.0676269,-118.3975928"], isMobile: false))
    
    // 98
    itemsList.append(Item(name: "Sweet Lady Jane", number: 98, item: "Berry Cake", visited: false, coords: ["34.083379,-118.372525"], isMobile: false))
    
    // 99
    itemsList.append(Item(name: "Daikokuya Ramen", number: 99, item: "Spicy Miso Ramen", visited: false, coords: ["34.0500021,-118.2400679","34.0379806,-118.4407598","34.0629513,-118.1348684","34.062983,-118.052452"], isMobile: false))
    
    // 100
    itemsList.append(Item(name: "Pie'n Burger", number: 100, item: "Cheeseburger ", visited: false, coords: ["34.1360062,-118.1314835"], isMobile: false))
    
    return itemsList
}
