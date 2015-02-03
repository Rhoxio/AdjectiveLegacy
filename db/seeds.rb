Item.create!(name: "Short Sword", description: "A basic sword for combat. Stout and sturdy.", value: 50, item_type: "weapon", item_effect: "none", attack_modifier: 3, defense_modifier: 1)
Item.create!(name: "Yew Bow", description: "A basic bow for combat. Quite flexible.", value: 50, item_type: "weapon", item_effect: "none", attack_modifier: 3, defense_modifier: 1)
Item.create!(name: "Bandit Knife", description: "An easily concealable weapon. It has been some use.", value: 50, item_type: "weapon", item_effect: "none", attack_modifier: 3, defense_modifier: 1)
Item.create!(name: "Short Staff", description: "A staff made of wood. Holds little magical energy.", value: 50, item_type: "weapon", item_effect: "none", attack_modifier: 3, defense_modifier: 1)

Item.create!(name: "Bastard Sword", description: "Used for killing bastards. Not really. It's a slightly shorter longsword.", value: 75, item_type: "weapon", item_effect: "none", attack_modifier: 5, defense_modifier: 2)
Item.create!(name: "Recurve Bow", description: "Stronger and easier to use than a longbow. Better for close-range fighting.", value: 75, item_type: "weapon", item_effect: "none", attack_modifier: 5, defense_modifier: 2)
Item.create!(name: "Shanking Knife", description: "Not your standard prison tool. A longer blade gives more kill potential.", value: 75, item_type: "weapon", item_effect: "none", attack_modifier: 5, defense_modifier: 2)
Item.create!(name: "Quarterstaff", description: "Made from elm. This staff holds a substantial amount of power.", value: 50, item_type: "weapon", item_effect: "none", attack_modifier: 5, defense_modifier: 2)

Item.create!(name: "Trinity", description: "A longsword insufed with some sort of magical energy. Has the propensity to empower attacks.", value: 100, item_type: "weapon", item_effect: "none", attack_modifier: 10, defense_modifier: 3)
Item.create!(name: "Ethereal Bow", description: "Upon drawing the string, an arrow is magically generated. Legolas doesn't need this. (Usually...)", value: 100, item_type: "weapon", item_effect: "none", attack_modifier: 10, defense_modifier: 2)
Item.create!(name: "Clamor, Render of Kings", description: "This famous dagger was buried in King Tyrandus's neck when he was giving a speech. The dagger that started a 100 year war.", value: 100, item_type: "weapon", item_effect: "none", attack_modifier: 10, defense_modifier: 3)
Item.create!(name: "Spire of the Nether", description: "Lightning crackles at the tip of this greatstaff. Hold immense magical energy", value: 100, item_type: "weapon", item_effect: "none", attack_modifier: 10, defense_modifier: 3)

# Item.create!(name: "Flail", description: "A weapon for breaking through armor.", value: 50, item_type: "weapon", item_effect: "armor-pierce", attack_modifier: 3, defense_modifier: 0)
# Item.create!(name: "Warhammer", description: "A heavy weapon for crushing and breaking bones.", value: 70, item_type: "weapon", item_effect: "stun", attack_modifier: 6, defense_modifier: 0)
# Item.create!(name: "Dagger", description: "A short blade for thrusting. Choice weapon for stelthy types.", value: 45, item_type: "weapon", item_effect: "none", attack_modifier: 2, defense_modifier: 0)
# Item.create!(name: "Oak Staff", description: "A solid staff for casting spells. ", value: 55, item_type: "weapon", item_effect: "cast", attack_modifier: 2, defense_modifier: 0)
# Item.create!(name: "Simple Focus", description: "A weapon for the off-hand. Focuses magical energy.", value: 35, item_type: "shield", item_effect: "focus", attack_modifier: 1, defense_modifier: 1)
# Item.create!(name: "Kite Shield", description: "A solid shield for deflecting attacks.", value: 50, item_type: "shield", item_effect: "block", attack_modifier: 0, defense_modifier: 3)

# Item.create!(name: "Health Potion", description: "Heals 25% of your total hp.", value: 10, item_type: "consumable", item_effect: "hp")
# Item.create!(name: "Booze", description: "Smells potent...", value: 12, item_type: "consumable", item_effect: "drunkeness", attack_modifier: 0, defense_modifier: 0)
# Item.create!(name: "Special Draught", description: "Boosts energy. Made from Cocainum.", value: 30, item_type: "consumable", item_effect: "special", attack_modifier: 0, defense_modifier: 0)

# Item.create!(name: "Ruby", description: "What this is written in. A red gem with moderate value.", value: 100, item_type: "good", item_effect: "codespit", attack_modifier: 0, defense_modifier: 0)
# Item.create!(name: "Tome", description: "An old tome with no cover art. How boring.", value: 15, item_type: "good", item_effect: "")


Enemy.create!(name: 'Rat', enemy_class: "beast", avatar: "/css/images/enemies/rat.jpg", level: 1, exp: 5, max_hp: 10, current_hp: 10, skill: 0, attack_rating: 1, initiative: 1, defense: 0)

Enemy.create!(name: 'Training Dummy', enemy_class: "dummy", avatar: "/css/images/enemies/dummy.jpg", level: 1, exp: 0, max_hp: 100000, current_hp: 100000, skill: 0, attack_rating: 0, initiative: 0, defense: 0)

Enemy.create!(name: 'Large Spider', enemy_class: "beast", avatar: "/css/images/enemies/spider.png", level: 2, exp: 10, max_hp: 70, current_hp: 70, skill: 0, attack_rating: 3, initiative: 2, defense: 0)

Enemy.create!(name: 'Wilds Warrior', enemy_class: "humanoid", avatar: "/css/images/enemies/barbarian.png", level: 3, exp: 15, max_hp: 80, current_hp: 80, skill: 1, attack_rating: 4, initiative: 0, defense: 1)

Enemy.create!(name: 'Pissed Pirate', enemy_class: "humanoid", avatar: "/css/images/enemies/pissed_pirate.jpg", level: 5, exp: 35, max_hp: 110, current_hp: 110, skill: 3, attack_rating: 8, initiative: 3, defense: 3)

Enemy.create!(name: 'Sea Crocodile', enemy_class: "beast", avatar: "/css/images/enemies/sea_crocodile.png", level: 6, exp: 45, max_hp: 130, current_hp: 130, skill: 2, attack_rating: 9, initiative: 2, defense: 4)

Enemy.create!(name: 'Smuggler', enemy_class: "humanoid", avatar: "/css/images/enemies/smuggler.png", level: 4, exp: 25, max_hp: 100, current_hp: 100, skill: 3, attack_rating: 7, initiative: 4, defense: 3)

Enemy.create!(name: "Captain 'Pretty Boy' Wilkes", enemy_class: "humanoid", avatar: "/css/images/coast_graphics/pirate_captain.png", level: 10, exp: 350, max_hp: 350, current_hp: 350, skill: 7, attack_rating: 20, initiative: 5, defense: 7)

Enemy.create!(name: "Rabid Stray Dog", enemy_class: "beast", avatar: "/css/images/rabid_dog.png", level: 2, exp: 10, max_hp: 30, current_hp: 30, skill: 1, attack_rating: 4, initiative: 1, defense: 1)

Enemy.create!(name: "Ice Golem", enemy_class: "elemental", avatar: "/css/images/mountain_graphics/ice_golem.png", level: 7, exp: 55, max_hp: 150, current_hp: 150, skill: 3, attack_rating: 10, initiative: 4, defense: 5)

Enemy.create!(name: "Bandit Sergeant", enemy_class: "humanoid", avatar: "/css/images/mountain_graphics/bandit-sergeant.jpg", level: 8, exp: 65, max_hp: 160, current_hp: 160, skill: 4, attack_rating: 11, initiative: 7, defense: 4)

Enemy.create!(name: "Raksasha", enemy_class: "humanoid", avatar: "/css/images/mountain_graphics/yeti.jpg", level: 11, exp: 370, max_hp: 400, current_hp: 400, skill: 5, attack_rating: 24, initiative: 8, defense: 7)

Enemy.create!(name: "Malus, King of Hadnar", enemy_class: "humanoid", avatar: "/css/images/barbarian.jpg", level: 6, exp: 140, max_hp: 150, current_hp: 150, skill: 3, attack_rating: 10, initiative: 4, defense: 4)

#LOCATIONS-----------------------

Location.create!(name: 'Grand Central', js_view: "/js/main-city/view.js", js_controller: "/js/main-city/controller.js", js_battle: "/js/main-city/battle.js", battle_background: "/css/images/courtyard.png", enemy_types: [1,2], coordinates: "00")

Location.create!(name: 'Old Forest', js_view: "/js/forest/view.js", js_controller: "/js/forest/controller.js", js_battle: "/js/forest/battle.js", battle_background: "/css/images/forest_clearing.png", enemy_types: [3,4], coordinates: "01")

Location.create!(name: 'Luccini Coast', js_view: "/js/coast_city/view.js", js_controller: "/js/coast_city/controller.js", js_battle: "/js/main-city/battle.js", battle_background: "/css/images/coast_graphics/causeway.jpg", enemy_types: [5,6,7], coordinates: "-10")

Location.create!(name: 'Roknar Fjords', js_view: "/js/fjord/view.js", js_controller: "/js/coast_city/controller.js", js_battle: "/js/main-city/battle.js", battle_background: "/css/images/mountain_graphics/mountain_pass.jpg", enemy_types: [10, 11], coordinates: "10")

# Catches----------------------------------------------------

Location.create!(name: 'In Development!', js_view: "/js/developing/developing.js", js_controller: "/js/coast_city/controller.js", js_battle: "/js/main-city/battle.js", battle_background: "/css/images/mountain_graphics/mountain_pass.jpg", enemy_types: [10, 11], coordinates: "0-1")

Location.create!(name: 'In Development!', js_view: "/js/developing/developing.js", js_controller: "/js/coast_city/controller.js", js_battle: "/js/main-city/battle.js", battle_background: "/css/images/mountain_graphics/mountain_pass.jpg", enemy_types: [10, 11], coordinates: "-20")
Location.create!(name: 'In Development!', js_view: "/js/developing/developing.js", js_controller: "/js/coast_city/controller.js", js_battle: "/js/main-city/battle.js", battle_background: "/css/images/mountain_graphics/mountain_pass.jpg", enemy_types: [10, 11], coordinates: "20")
Location.create!(name: 'In Development!', js_view: "/js/developing/developing.js", js_controller: "/js/coast_city/controller.js", js_battle: "/js/main-city/battle.js", battle_background: "/css/images/mountain_graphics/mountain_pass.jpg", enemy_types: [10, 11], coordinates: "02")
Location.create!(name: 'In Development!', js_view: "/js/developing/developing.js", js_controller: "/js/coast_city/controller.js", js_battle: "/js/main-city/battle.js", battle_background: "/css/images/mountain_graphics/mountain_pass.jpg", enemy_types: [10, 11], coordinates: "11")
Location.create!(name: 'In Development!', js_view: "/js/developing/developing.js", js_controller: "/js/coast_city/controller.js", js_battle: "/js/main-city/battle.js", battle_background: "/css/images/mountain_graphics/mountain_pass.jpg", enemy_types: [10, 11], coordinates: "-11")
Location.create!(name: 'In Development!', js_view: "/js/developing/developing.js", js_controller: "/js/coast_city/controller.js", js_battle: "/js/main-city/battle.js", battle_background: "/css/images/mountain_graphics/mountain_pass.jpg", enemy_types: [10, 11], coordinates: "02")
Location.create!(name: 'In Development!', js_view: "/js/developing/developing.js", js_controller: "/js/coast_city/controller.js", js_battle: "/js/main-city/battle.js", battle_background: "/css/images/mountain_graphics/mountain_pass.jpg", enemy_types: [10, 11], coordinates: "-1-1")
Location.create!(name: 'In Development!', js_view: "/js/developing/developing.js", js_controller: "/js/coast_city/controller.js", js_battle: "/js/main-city/battle.js", battle_background: "/css/images/mountain_graphics/mountain_pass.jpg", enemy_types: [10, 11], coordinates: "1-1")
Location.create!(name: 'In Development!', js_view: "/js/developing/developing.js", js_controller: "/js/coast_city/controller.js", js_battle: "/js/main-city/battle.js", battle_background: "/css/images/mountain_graphics/mountain_pass.jpg", enemy_types: [10, 11], coordinates: "0-2")

Battle.create!



