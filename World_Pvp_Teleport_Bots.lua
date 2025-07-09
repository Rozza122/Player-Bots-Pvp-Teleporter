--Spawner script for pvp locations by Rozza121 for use with https://github.com/liyunfan1223/azerothcore-wotlk
--09-07-2025 v0.1 (very early days, not finished yet...)

local trackedPlayers = {}
local lastTriggerTime = {}
local LEVEL_DIFFERENCE = 3 --Level difference allowed for pvp duel invites.

local AREA_CONFIGS = {
   -- Outland
    [3628] = {
		enabled = true,
        minLevel = 60,
        maxLevel = 68,
        maxToTeleport = 50,
        forFaction = "Both",
        pvpType = "worldpvp",
        locations = {
            { map = 530, x = -1563.42, y = 7927.73, z = -21.81, o = 1.52 },
            { map = 530, x = -1555.35, y = 7954.65, z = -22.20, o = 3.98 },
            { map = 530, x = -1584.59, y = 7967.20, z = -22.44, o = 5.15 },
            { map = 530, x = -1565.40, y = 7896.60, z = -22.09, o = 1.64 },
            { map = 530, x = -1573.77, y = 7931.30, z = -22.49, o = 1.56 }
        }
    },
    [3671] = {
		enabled = true,
        minLevel = 60,
        maxLevel = 64,
        maxToTeleport = 8,
        forFaction = "Both",
        pvpType = "worldpvp",
        locations = {
            { map = 530, x = -466.30, y = 3440.20, z = 34.16, o = 2.11 },
            { map = 530, x = -479.80, y = 3461.11, z = 35.95, o = 5.36 },
            { map = 530, x = -479.47, y = 3442.12, z = 34.30, o = 0.80 },
            { map = 530, x = -460.75, y = 3458.84, z = 35.75, o = 3.74 }
        }
    },
    [3670] = {
		enabled = true,
        minLevel = 60,
        maxLevel = 64,
        maxToTeleport = 8,
        forFaction = "Horde",
        pvpType = "worldpvp",
        locations = {
            { map = 530, x = -186.01, y = 3469.78, z = 39.57, o = 1.33 },
            { map = 530, x = -177.93, y = 3472.95, z = 40.92, o = 2.61 },
            { map = 530, x = -184.61, y = 3483.21, z = 39.39, o = 4.82 },
            { map = 530, x = -187.32, y = 3476.35, z = 39.03, o = 0.28 }
        }
    },
    [3669] = {
		enabled = true,
        minLevel = 60,
        maxLevel = 64,
        maxToTeleport = 8,
        forFaction = "Both",
        pvpType = "worldpvp",
        locations = {
            { map = 530, x = -292.40, y = 3709.22, z = 57.68, o = 5.05 },
            { map = 530, x = -281.21, y = 3701.20, z = 58.07, o = 2.46 },
            { map = 530, x = -306.80, y = 3701.45, z = 61.15, o = 6.08 },
            { map = 530, x = -271.98, y = 3703.64, z = 61.96, o = 2.84 }
        }
    },
    [3720] = {
		enabled = true,
        minLevel = 60,
        maxLevel = 64,
        maxToTeleport = 12,
        forFaction = "Both",
        pvpType = "worldpvp",
        locations = {
            { map = 530, x = 367.08, y = 7334.12, z = 48.91, o = 3.00 },
            { map = 530, x = 339.12, y = 6833.12, z = 48.03, o = 3.00 }
        }
    },
	-- Outland
    [14] = { --Orgrimmar
		enabled = true,
        minLevel = 19,
        maxLevel = 80,
        maxToTeleport = 150,
        forFaction = "Horde",
        pvpType = "duelpvp",
        locations = {
            { map = 1, x = 1325.61, y = -4382.63, z = 26.23, o = 3.59 },
            { map = 1, x = 1306.28, y = -4389.38, z = 26.26, o = 0.38 },
			{ map = 1, x = 1193.67, y = -4394.72, z = 23.31, o = 5.11 },
			{ map = 1, x = 1205.56, y = -4396.09, z = 23.57, o = 3.75 },
			{ map = 1, x = 1206.69, y = -4419.00, z = 21.68, o = 1.74 },
			{ map = 1, x = 1185.78, y = -4416.14, z = 21.74, o = 1.66 },
			{ map = 1, x = 1178.75, y = -4407.00, z = 21.71, o = 6.10 },
			{ map = 1, x = 1206.04, y = -4432.74, z = 21.39, o = 1.18 },
			{ map = 1, x = 1237.52, y = -4421.36, z = 22.92, o = 2.64 },
			{ map = 1, x = 1216.25, y = -4429.04, z = 21.41, o = 0.59 },
			{ map = 1, x = 1252.65, y = -4422.32, z = 23.96, o = 0.76 },
			{ map = 1, x = 1248.42, y = -4409.30, z = 24.55, o = 4.81 },
			{ map = 1, x = 1271.33, y = -4438.81, z = 26.76, o = 0.96 },
			{ map = 1, x = 1252.00, y = -4410.42, z = 24.81, o = 4.87 },
			{ map = 1, x = 1264.03, y = -4407.47, z = 25.80, o = 0.27 },
			{ map = 1, x = 1276.05, y = -4391.05, z = 26.64, o = 0.74 },
			{ map = 1, x = 1274.28, y = -4374.53, z = 28.40, o = 6.28 },
			{ map = 1, x = 1282.01, y = -4414.10, z = 26.49, o = 5.63 },
			{ map = 1, x = 1317.69, y = -4423.11, z = 26.09, o = 2.77 },
			{ map = 1, x = 1307.83, y = -4439.21, z = 26.22, o = 1.77 },
			{ map = 1, x = 1331.27, y = -4406.59, z = 27.23, o = 2.32 },
			{ map = 1, x = 1324.26, y = -4376.83, z = 26.22, o = 6.24 },
			{ map = 1, x = 1335.88, y = -4364.02, z = 27.28, o = 5.37 },
			{ map = 1, x = 1351.70, y = -4393.17, z = 28.61, o = 2.23 },
			{ map = 1, x = 1364.97, y = -4378.73, z = 26.08, o = 2.35 },
			{ map = 1, x = 1354.70, y = -4364.08, z = 26.51, o = 4.18 },
			{ map = 1, x = 1331.87, y = -4350.44, z = 28.28, o = 4.33 },
			{ map = 1, x = 1303.56, y = -4372.09, z = 27.93, o = 4.29 },
			{ map = 1, x = 1282.05, y = -4384.06, z = 28.60, o = 5.31 },
			{ map = 1, x = 1291.40, y = -4404.89, z = 26.32, o = 2.20 },
			{ map = 1, x = 1316.68, y = -4399.03, z = 26.39, o = 2.00 },
			{ map = 1, x = 1302.50, y = -4378.19, z = 27.39, o = 4.81 },
			{ map = 1, x = 1338.29, y = -4377.38, z = 26.20, o = 2.71 },
			{ map = 1, x = 1326.08, y = -4372.91, z = 26.21, o = 4.47 },
			{ map = 1, x = 1305.31, y = -4373.73, z = 28.03, o = 5.13 },
			{ map = 1, x = 1286.98, y = -4408.45, z = 26.42, o = 2.96 },
			{ map = 1, x = 1274.75, y = -4388.55, z = 28.17, o = 3.69 },
			{ map = 1, x = 1243.67, y = -4417.83, z = 23.56, o = 1.11 },
			{ map = 1, x = 1271.63, y = -4392.31, z = 26.32, o = 0.62 },
			{ map = 1, x = 1301.79, y = -4406.86, z = 26.46, o = 6.23 },
			{ map = 1, x = 1328.85, y = -4399.06, z = 27.57, o = 2.17 },
			{ map = 1, x = 1205.98, y = -4375.11, z = 24.68, o = 5.08 },
        }
    },
	[12] = { --Stormwind
		enabled = true,
        minLevel = 19,
        maxLevel = 80,
        maxToTeleport = 150,
        forFaction = "Alliance",
        pvpType = "duelpvp",
        locations = {
			{ map = 0, x = -9136.51, y = 330.86, z = 92.32, o = 1.36 },
			{ map = 0, x = -9123.33, y = 337.94, z = 93.90, o = 2.80 },
			{ map = 0, x = -9128.70, y = 350.20, z = 93.58, o = 4.03 },
			{ map = 0, x = -9140.44, y = 362.04, z = 91.15, o = 4.05 },
			{ map = 0, x = -9145.42, y = 346.89, z = 90.57, o = 0.39 },
			{ map = 0, x = -9120.34, y = 369.24, z = 93.29, o = 3.92 },
			{ map = 0, x = -9106.40, y = 369.01, z = 93.45, o = 4.49 },
			{ map = 0, x = -9084.29, y = 351.47, z = 93.01, o = 4.54 },
			{ map = 0, x = -9068.64, y = 344.09, z = 93.06, o = 4.33 },
			{ map = 0, x = -9066.33, y = 329.33, z = 93.93, o = 3.10 },
			{ map = 0, x = -9072.76, y = 358.97, z = 94.20, o = 3.41 },
			{ map = 0, x = -9104.87, y = 324.17, z = 93.49, o = 1.72 },
			{ map = 0, x = -9126.63, y = 313.08, z = 93.67, o = 0.28 },
			{ map = 0, x = -9114.79, y = 305.02, z = 93.75, o = 1.21 },
			{ map = 0, x = -9105.29, y = 292.73, z = 93.55, o = 1.54 },
			{ map = 0, x = -9153.30, y = 340.63, z = 88.65, o = 6.17 },
			{ map = 0, x = -9161.09, y = 359.43, z = 89.05, o = 0.29 },
			{ map = 0, x = -9147.05, y = 368.25, z = 90.32, o = 6.15 },
			{ map = 0, x = -9136.54, y = 371.61, z = 90.56, o = 5.11 },
			{ map = 0, x = -9126.00, y = 363.88, z = 92.69, o = 0.47 },
			{ map = 0, x = -9119.84, y = 379.62, z = 91.72, o = 0.88 },
			{ map = 0, x = -9113.57, y = 373.45, z = 93.89, o = 4.20 },
			{ map = 0, x = -9112.00, y = 335.14, z = 93.30, o = 5.90 },
			{ map = 0, x = -9110.18, y = 328.10, z = 93.27, o = 2.80 },
			{ map = 0, x = -9126.44, y = 319.95, z = 93.48, o = 4.67 },
			{ map = 0, x = -9119.63, y = 315.38, z = 93.08, o = 0.31 },
			{ map = 0, x = -9091.05, y = 318.41, z = 93.86, o = 1.11 },
			{ map = 0, x = -9103.87, y = 329.04, z = 93.68, o = 2.41 }
        }
    },
	[87] = { --Goldshire
		enabled = true,
        minLevel = 80,
        maxLevel = 80,
        maxToTeleport = 15,
        forFaction = "Alliance",
        pvpType = "duelpvp",
        locations = {
			{ map = 0, x = -9480.67, y = 56.84, z = 56.39, o = 0.04 },
			{ map = 0, x = -9466.45, y = 54.95, z = 56.76, o = 6.15 },
			{ map = 0, x = -9468.40, y = 62.74, z = 55.91, o = 3.18 },
			{ map = 0, x = -9462.09, y = 73.44, z = 56.61, o = 5.30 },
			{ map = 0, x = -9450.23, y = 65.10, z = 56.10, o = 2.22 },
			{ map = 0, x = -9443.49, y = 48.31, z = 56.60, o = 2.57 },
			{ map = 0, x = -9437.26, y = 51.63, z = 56.27, o = 2.61 },
			{ map = 0, x = -9439.22, y = 67.48, z = 56.12, o = 3.00 },
			{ map = 0, x = -9444.83, y = 81.16, z = 57.58, o = 4.73 },
			{ map = 0, x = -9468.59, y = 53.95, z = 57.02, o = 4.32 },
			{ map = 0, x = -9464.41, y = 61.72, z = 55.92, o = 1.29 },
			{ map = 0, x = -9477.35, y = 74.45, z = 56.67, o = 4.74 },
			{ map = 0, x = -9492.33, y = 54.43, z = 55.98, o = 1.19 },
			{ map = 0, x = -9490.98, y = 46.15, z = 56.60, o = 1.37 },
			{ map = 0, x = -9482.67, y = 80.66, z = 56.51, o = 4.54 },
			{ map = 0, x = -9459.52, y = 43.94, z = 56.95, o = 1.47 },
			{ map = 0, x = -9436.07, y = 45.42, z = 56.77, o = 2.06 }
        }
    },
	[4570] = { --Circle of Wills (need to remove dalaran (4395) from AiPlayerbot.PvpProhibitedZoneIds)
		enabled = true,
        minLevel = 80,
        maxLevel = 80,
        maxToTeleport = 35,
        forFaction = "Both",
        pvpType = "duelpvp",
        locations = {
			{ map = 571, x = 5845.03, y = 674.35, z = 609.89, o = 3.11 },
			{ map = 571, x = 5835.20, y = 685.48, z = 609.89, o = 4.40 },
			{ map = 571, x = 5818.27, y = 679.45, z = 609.89, o = 0.00 },
			{ map = 571, x = 5820.44, y = 664.34, z = 609.89, o = 0.70 },
			{ map = 571, x = 5831.12, y = 658.84, z = 609.89, o = 1.87 },
			{ map = 571, x = 5833.73, y = 676.55, z = 609.89, o = 0.30 },
			{ map = 571, x = 5825.93, y = 668.81, z = 609.89, o = 1.51 },
			{ map = 571, x = 5835.39, y = 675.78, z = 609.89, o = 4.35 },
			{ map = 571, x = 5806.23, y = 628.68, z = 609.89, o = 2.37 },
			{ map = 571, x = 5809.70, y = 646.73, z = 609.89, o = 2.97 },
			{ map = 571, x = 5792.66, y = 643.82, z = 609.89, o = 4.87 },
			{ map = 571, x = 5800.49, y = 633.84, z = 609.89, o = 0.34 },
			{ map = 571, x = 5797.93, y = 643.57, z = 609.89, o = 5.81 },
			{ map = 571, x = 5773.63, y = 601.42, z = 609.89, o = 1.69 },
			{ map = 571, x = 5777.76, y = 614.40, z = 609.89, o = 0.47 },
			{ map = 571, x = 5786.36, y = 611.06, z = 609.89, o = 4.38 },
			{ map = 571, x = 5764.29, y = 602.94, z = 609.89, o = 0.50 },
			{ map = 571, x = 5776.69, y = 596.44, z = 609.89, o = 1.95 },
			{ map = 571, x = 5753.02, y = 603.21, z = 611.75, o = 0.44 }
        }
    }
}

local duelRequests = {
    "Your gear looks shiny, but can it take a punch? Duel me!",
    "I bet my grandma's faster than you. Prove me wrong in a duel!",
    "Careful, dueling me might hurt your ego. You still in?",
    "Let's duel. Winner gets bragging rights for a week!",
    "I heard you're all talk. Let's see some action in a duel!",
    "Time to settle who's better. Hint: It's me. Duel?",
    "If I win, you owe me a gold. If you win... well, that's not happening!",
    "Your DPS is trash. Prove me wrong in a duel!",
    "You look tough. Duel me so I can show everyone you're not!",
    "Let's duel! First to cry loses!",
    "Are you scared? I swear I won't use all my cooldowns... maybe.",
    "Duel me, or forever live with the shame of running away!",
    "You look like someone who loses duels. Care to prove me right?",
    "They say practice makes perfect. Duel me so I can perfect destroying you!",
    "I hope you brought a healer... 'cause you're gonna need one!",
    "Dueling me is free, but the humiliation costs extra. You in?",
    "You can't win, but you can try! Duel me!",
    "If you win this duel, I'll uninstall. If I win, you reroll! Deal?",
    "Come on, don't be shy! I need someone to test my new build on!",
    "I'm bored. Entertain me with your pathetic attempts to win. Duel?",
    "My pet could probably beat you in a duel. Wanna try?",
    "I heard you’re the king of losing duels. Let’s see if it’s true!",
    "Duel me, and I’ll show you what true regret feels like!",
    "This is your chance to lose with dignity. Duel me now!",
    "I’ve fought NPCs tougher than you. Prove me wrong!",
    "You think you’re good? Let’s put that theory to the test!",
    "I hope your repair bill isn’t too high after this duel!",
    "I could beat you with my eyes closed. Duel me!",
    "Winner gets bragging rights, loser gets a life lesson. Deal?",
    "No hard feelings after this duel, okay? Just kidding, there will be!",
    "Let’s duel. I’ll even let you land a hit before I destroy you!",
    "Are you ready to see your health bar disappear? Duel me!",
    "I’ve seen level 1s put up a better fight than you. Duel?",
    "How about a friendly duel? Friendly for me, painful for you!",
    "You’ve been standing still too long. Let’s fix that with a duel!",
    "Let’s duel, and I’ll teach you why you shouldn’t mess with me!",
    "Do you want to lose fast or slow? Duel me and choose your fate!",
    "Dueling me is like fighting a raid boss... you’ve been warned!",
    "You couldn’t hit the broad side of a barn. Duel me anyway!",
    "Prepare to get absolutely wrecked. Duel me!",
    "I’ll give you three seconds to run before this duel starts!",
    "You look like you’ve never dueled before. Want me to show you how?",
    "Time to prove who the real champion is. Spoiler: It’s not you!",
    "Your confidence is cute. Let’s see how long it lasts in a duel!",
    "You vs. me. No escape, no excuses. Let’s duel!",
    "I hope you’re not afraid of public humiliation. Duel me!",
    "A duel with me is like a one-way ticket to the graveyard. Ready?",
    "Duel me, and I promise to go easy... for the first second!",
    "You’re about to experience the art of destruction. Duel me!",
    "Want to see the difference between skill and luck? Duel me!",
    "Your PvP skills are about to be exposed. Duel me!",
    "Step right up for your free lesson in losing. Duel me!",
    "You’ve got guts challenging me. Let’s see if they spill in a duel!",
    "Duel me. I’ve been itching to crush someone today!",
    "Your reputation is on the line. Duel me to save it!",
    "Get ready to eat dirt. Duel me now!",
    "Let’s see how good you really are. Spoiler: Not very. Duel?",
    "It’s time for your daily dose of humiliation. Duel me!",
    "Duel me if you dare. Spoiler: You’ll regret it!",
    "I’ve got time to kill and you’re the perfect victim. Duel?",
    "Your health bar won’t know what hit it. Duel me!",
    "Think fast! Oh wait, you can’t. Duel me!",
    "Dueling me is like trying to stop a hurricane with a paper umbrella. Ready?",
    "If losing was an art, you’d be a masterpiece. Duel me!",
    "I’ve fought tougher training dummies than you. Duel?",
    "Time to settle this once and for all. Duel me now!",
    "You’re about to regret that last comment. Duel me!",
    "Duel me. I promise not to laugh too hard... maybe.",
    "You’re about to witness true PvP mastery. Duel me!",
    "You call that a weapon? Let me show you what a real one can do. Duel?",
    "I’ll let you hit me first. Not that it’ll help. Duel me!",
    "Time to separate the noobs from the pros. Duel me!",
    "You look like someone who could use a reality check. Duel?",
    "Let’s see if you can back up all that trash talk. Duel me!",
    "Don’t worry, I’ll try not to embarrass you too much. Duel?",
    "Your confidence is inspiring... and misplaced. Duel me!",
    "Step into the ring with me if you’re ready to lose. Duel?",
    "You’re about to find out why I’m undefeated. Duel me!",
    "Let’s duel and see if you can last longer than 10 seconds!",
    "If I lose, I’ll eat my hat. But that’s not happening. Duel me!",
    "Duel me. I’ll even let you borrow my gear... not that it’ll help!",
    "This duel won’t take long. Let’s get it over with!",
    "You’ve been selected for today’s PvP practice. Duel me!",
    "Time to show everyone why you’re just a benchwarmer. Duel?",
    "You vs. me. Let’s see who walks away and who crawls. Duel?",
    "This duel is brought to you by your incoming defeat. Ready?",
    "Your PvP skills are rusty. Let me sharpen them with this duel!",
    "Let’s duel. I promise it’ll be quick and painless. Just kidding!",
    "You’re about to learn why I’m the best. Duel me!",
    "I’ll let you win... in your dreams. Duel me!",
    "Your losing streak starts now. Duel me!",
    "Let’s duel. Don’t worry, it’s just for fun... for me!",
    "I’ve beaten players twice as skilled as you. Let’s duel!",
    "Your next duel is going to be your worst nightmare. Ready?",
    "Let’s see how far your luck takes you in a duel with me!",
    "Step up and face your fate. Duel me now!",
    "Dueling me is a mistake you’re about to make. Ready?",
    "I’ll take it easy on you. Not really. Duel me!",
	"Prepare yourself, %s! Let us duel!",
    "%s, I challenge you to a duel!",
    "Face me in combat, %s!",
    "%s, prove your strength in a duel!",
    "Let us test our skills, %s. I challenge you!",
    "%s, it's time to settle this in a duel!",
    "Do you have the courage to face me, %s?",
    "%s, let us see who the stronger warrior is!",
    "Take up your weapon, %s, and duel me!",
    "%s, meet me in the arena of honor!",
    "I demand a duel with you, %s!",
    "%s, are you ready to test your mettle?",
    "I challenge you to prove your worth, %s!",
    "%s, fight me if you dare!",
    "Let us settle this with a duel, %s!",
    "Show me what you are made of, %s!",
    "%s, let's see your combat skills!",
    "Step forward and face me, %s!",
    "%s, only one of us can walk away victorious!",
    "The battlefield awaits us, %s!",
    "%s, prepare for glory or defeat!",
    "Let's clash blades, %s!",
    "%s, prove yourself in battle!",
    "Do you have what it takes to beat me, %s?",
    "%s, let's see who is the better fighter!",
    "I await your challenge, %s!",
    "%s, stand and fight me!",
    "Show your courage, %s!",
    "%s, let us engage in honorable combat!",
    "A duel, %s! Show me your strength!",
    "Face your destiny, %s!",
    "%s, let us cross swords!",
    "Prepare to fight, %s!",
    "%s, let the best warrior win!",
    "I challenge you, %s, to a duel of honor!",
    "Prove you are a worthy opponent, %s!",
    "%s, let us duel for glory!",
    "Take this challenge, %s!",
    "%s, prepare to defend yourself!",
    "Let us battle, %s!",
    "%s, show me your strength on the battlefield!",
    "Step up and face me, %s!",
    "%s, prepare yourself for combat!",
    "Do you accept my challenge, %s?",
    "Let us see who the victor is, %s!",
    "%s, stand your ground and fight me!",
    "%s, prove your might!",
    "Let us test our blades, %s!",
    "I want to duel you, %s!",
    "%s, prepare to fight for your honor!",
    "Do you have the skill to defeat me, %s?",
    "%s, meet me in combat!",
    "Let us see whose technique prevails, %s!",
    "Prepare to face me, %s!",
    "%s, it is time to duel!",
    "Take this duel, %s!",
    "%s, ready your weapon!",
    "Let's see your skills, %s!",
    "%s, I want to see how you fight!",
    "Will you accept my challenge, %s?",
    "%s, it is time to test your strength!",
    "Let us engage in battle, %s!",
    "%s, come fight me!",
    "Are you prepared for battle, %s?",
    "%s, it's time to duel!",
    "%s, let us settle this with honor!",
    "Come and face me, %s!",
    "%s, your skills are about to be tested!",
    "I hope you are ready, %s!",
    "I call you to the battlefield, %s!",
    "%s, prepare for a duel!",
    "It's you and me, %s!",
    "Take this fight, %s!",
    "%s, show me what you are capable of!",
    "Stand ready, %s!",
    "%s, you cannot back down from this duel!",
    "It is time to fight, %s!",
    "%s, I will not hold back!",
    "A duel awaits us, %s!",
    "%s, let the combat begin!",
    "Bring your best, %s!",
    "Prepare yourself for a challenge, %s!",
    "%s, ready your courage!",
    "Will you fight me, %s?",
    "%s, the duel begins now!",
    "Stand tall, %s, and fight me!",
    "Do not hesitate, %s, face me now!",
    "%s, let us duel to see who prevails!",
    "Take this honor duel, %s!",
    "%s, prepare to face the ultimate test!",
    "A duel of skill awaits us, %s!",
    "The time has come, %s, let us fight!",
    "%s, may the best warrior win!",
    "%s, honor compels you to duel me!",
    "Let our skills decide, %s!",
    "To the battlefield, %s!"
}

local HORDE_RACES = { [2]=true, [5]=true, [6]=true, [8]=true, [10]=true, [26]=true }
local ALLIANCE_RACES = { [1]=true, [3]=true, [4]=true, [7]=true, [11]=true, [22]=true }

local function getFactionByRace(race)
    if HORDE_RACES[race] then return "Horde"
    elseif ALLIANCE_RACES[race] then return "Alliance"
    else return "Unknown" end
end

local function shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(1, i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
end

local function DuelLoop(guid)
    local player = GetPlayerByGUID(guid)
    if not player then return end

    if not player:InBattleground() and not player:InBattlegroundQueue() and not player:IsInGroup() and not player:IsInCombat() then
        local playerLevel = player:GetLevel()
        local playerZone = player:GetZoneId()

        if player:GetAccountName():sub(1, 6) == "RNDBOT" and not player:IsInCombat() and player:GetHealth() == player:GetMaxHealth() then
            local nearbyPlayers = player:GetPlayersInRange(10)
            for _, nearbyPlayer in ipairs(nearbyPlayers) do
                if nearbyPlayer:GetGUIDLow() ~= player:GetGUIDLow() and not nearbyPlayer:IsInGroup() then
                    local playerHealth = (player:GetHealth() / player:GetMaxHealth()) * 100
                    local nearbyPlayerLevel = nearbyPlayer:GetLevel()
                    local nearbyPlayerHealth = (nearbyPlayer:GetHealth() / nearbyPlayer:GetMaxHealth()) * 100
                    local nearbyPlayerName = nearbyPlayer:GetName()

                    if playerHealth >= 95 and nearbyPlayerHealth >= 95 then
                        if math.abs(playerLevel - nearbyPlayerLevel) <= LEVEL_DIFFERENCE then
							local moveId = math.random(0, 9999999)
							--local px, py, pz = nearbyPlayer:GetLocation()
							local x = nearbyPlayer:GetX()
							local y = nearbyPlayer:GetY()
							local z = nearbyPlayer:GetZ()
							local o = nearbyPlayer:GetO()

							local distanceAhead = 2

							local newX = x + math.cos(o) * distanceAhead
							local newY = y + math.sin(o) * distanceAhead
	
							player:MoveTo(moveId, x, y, z, o)
		
							if math.random(0, 20) == 0 then
								local randomIndex = math.random(1, #duelRequests)
								if player:GetTeam() == 1 then
									player:Say(string.format(duelRequests[randomIndex], nearbyPlayerName), 1)
								else
									player:Say(string.format(duelRequests[randomIndex], nearbyPlayerName), 7)
								end
							end
							player:CastSpell(nearbyPlayer, 7266, true)
							break
                        end
                    end
                end
            end
		else
			player:RemoveEvents()	
        end
    end
	
	local randomTimer = math.random(5000, 25000)
    CreateLuaEvent(function() DuelLoop(guid) end, randomTimer, 1)
end

local function StartDuelRoutine(player)
    DuelLoop(player:GetGUID())
end

local function OnLogin(event, player)
    trackedPlayers[player:GetGUIDLow()] = {
        level = player:GetLevel(),
        faction = getFactionByRace(player:GetRace()),
        fullGuid = player:GetGUID(),
		area = player:GetAreaId() -- Added
    }
end

local function OnLevelChanged(event, player, oldLevel)
    local entry = trackedPlayers[player:GetGUIDLow()]
    if entry then entry.level = player:GetLevel() end
end

local function OnLogout(event, player)
    trackedPlayers[player:GetGUIDLow()] = nil
end

local function OnUpdateZone(event, player, newZone, newArea)
    local config = AREA_CONFIGS[newArea]
	if trackedPlayers[player:GetGUIDLow()] then
        trackedPlayers[player:GetGUIDLow()].area = newArea
    end
    if not config or player:GetAccountName():sub(1, 6) == "RNDBOT" or not config.enabled then 
		player:RemoveEvents()
		return 
	end
    local horde, alliance = {}, {}
    for guid, data in pairs(trackedPlayers) do
        local p = GetPlayerByGUID(data.fullGuid)
        if p and p ~= player and not p:IsInCombat() and p:IsInWorld() then -- and not p:IsAFK()
            if data.level >= config.minLevel and data.level <= config.maxLevel then
                if data.faction == "Horde" then table.insert(horde, p)
                elseif data.faction == "Alliance" then table.insert(alliance, p) end
            end
        end
    end

    shuffle(horde) shuffle(alliance) shuffle(config.locations)

	local function GetPlayersInArea(areaId)
		local count = 0
		for _, info in pairs(trackedPlayers) do
			if info.area == areaId then
				count = count + 1
			end
		end
		return count
	end

	local function teleportGroup(group, count, offset)
		local teleported = 0
		local areaPlayerCount = GetPlayersInArea(newArea)

		for i = 1, count do
			if areaPlayerCount + teleported == config.maxToTeleport then
				break
			end

			local p = group[i]
			local loc = config.locations[((offset + i - 1) % #config.locations) + 1]
			if p then
				if config.pvpType == 'duelpvp' then
					StartDuelRoutine(p)
				end
				p:SetPvP(true)
				p:Teleport(loc.map, loc.x, loc.y, loc.z, loc.o)
				trackedPlayers[p:GetGUIDLow()].area = newArea
				teleported = teleported + 1
			end
		end
	end

    local faction = config.forFaction:lower()
    local maxPerFaction = math.floor(config.maxToTeleport / 2)
    if faction == "horde" then
        teleportGroup(horde, math.min(#horde, config.maxToTeleport), 0)
    elseif faction == "alliance" then
        teleportGroup(alliance, math.min(#alliance, config.maxToTeleport), 0)
    else
        teleportGroup(horde, math.min(#horde, maxPerFaction), 0)
        teleportGroup(alliance, math.min(#alliance, maxPerFaction), maxPerFaction)
    end
end

RegisterPlayerEvent(3, OnLogin)
RegisterPlayerEvent(13, OnLevelChanged)
RegisterPlayerEvent(4, OnLogout)
RegisterPlayerEvent(47, OnUpdateZone)