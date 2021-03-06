package classes.Scenes.Dungeons.HelDungeon
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;

	public class HarpyQueen extends Monster
	{
		public var spellCostWhitefire:int = 12;
		
		public function harpyQueenAI():void {
			if (rand(4) == 0) eldritchRopes();
			else if(rand(3) == 0 && fatigue <= (100 - spellCostWhitefire)) whitefire();
			else if(rand(2) == 0) lustSpikeAttack();
			else windSlamAttack();
		}
		//ATTACK ONE: ELDRITCH ROPES
		public function eldritchRopes():void {
			outputText("The Harpy Queen flicks her left wrist at you. Before you can blink, ropes of white-hot magic hurtle toward you. You manage to duck and dodge a few of them, but a pair still grab your wrists, pulling painfully at your arms.");
			//(Effect: Grab + Physical Damage)
			var damage:int = 25 + rand(10);
			damage = player.takeDamage(damage, true);
			createStatusEffect(StatusEffects.QueenBind,0,0,0,0);
			combatRoundOver();
		}

		public function ropeStruggles(wait:Boolean = false):void {
			clearOutput();
			//Struggle Fail: 
			if(rand(10) > 0 && player.str/5 + rand(20) < 23 || wait) {
				outputText("You give a mighty try, but cannot pull free of the magic ropes!  The Harpy Queen laughs uproariously, pulling at your arms harder.");
				if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {var damage:int = 25 + rand(10);
				damage = player.takeDamage(damage, true);
				}
			}
			else {
				outputText("With supreme effort, you pull free of the magic ropes, causing the queen to tumble to her hands and knees.");
				removeStatusEffect(StatusEffects.QueenBind);
			}
			combatRoundOver();
		}

		//ATTACK TWO: LUST SPIKE
		public function lustSpikeAttack():void {
			outputText("The Harpy Queen draws a strange arcane circle in the air, lines of magic remaining wherever the tip of her staff goes.  You try to rush her, but the circle seems to have created some kind of barrier around her.  You can only try to force it open - but too late!  A great pink bolt shoots out of the circle, slamming into your chest.  You suddenly feel light-headed and so very, very horny...");
			//(Effect: Heavy Lust Damage)
			player.dynStats("lus", 40);
			combatRoundOver();
		}

		//ATTACK THREE: Wind Slam!
		public function windSlamAttack():void {
			outputText("The queen swings her arm at you and, despite being a few feet away, you feel a kinetic wall slam into you, and you go flying - right into the harpy brood!  You feel claws, teeth and talons dig into you, but you're saved by a familiar pair of scaled arms.  \"<i>Get back in there!</i>\" Helia shouts, throwing you back into the battle!");
			//(Effect; Heavy Damage)
			var damage:Number = 100 + rand(50);
			damage = player.takeDamage(damage, true);
			combatRoundOver();
		}
		
		//ATTACK FOUR: Whitefire!
		public function whitefire():void {
			outputText("The queen narrows her eyes and focuses her mind with deadly intent. She snaps her fingers and you are enveloped in a flash of white flames!");
			var damage:int = inte + rand(50) * SpellMod();
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
			if (player.hasStatusEffect(StatusEffects.Blizzard)) {
			player.addStatusValue(StatusEffects.Blizzard, 1, -1);
			outputText("Luckly protective ice maelstorm still surrounding you lessening amount of damage.  ");
			damage *= 0.2;
			}
			if (player.isGoo()) {
				damage *= 1.5;
				outputText("It's super effective! ");
			}
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) damage *= 1.15;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) damage *= 1.3;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) damage *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) damage *= 2;
			damage = Math.round(damage);
			player.takeDamage(damage, true);
			fatigue += spellCostWhitefire;
			combatRoundOver();
		}
		
		public function SpellMod():Number {
			var mod:Number = 1;
			if (findPerk(PerkLib.JobSorcerer) >= 0) mod += .1;
			if (findPerk(PerkLib.Mage) >= 0) mod += .2;
			if (findPerk(PerkLib.Spellpower) >= 0) mod += .2;
			if (findPerk(PerkLib.WizardsFocus) >= 0) mod += .6;
			return mod;
		}
		
		override protected function performCombatAction():void
		{
			harpyQueenAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.dungeons.heltower.harpyQueenDefeatedByPC();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.dungeons.heltower.harpyQueenBeatsUpPCBadEnd();
		}

		public function HarpyQueen()
		{
			this.a = "the ";
			this.short = "Harpy Queen";
			this.imageName = "harpyqueen";
			this.long = "You face the Harpy Queen, a broodmother of epic proportions - literally.  Her hips are amazingly wide, thrice her own width at the least, and the rest of her body is lushly voluptuous, with plush, soft thighs and a tremendous butt.  Her wide wings beat occasionally, sending ripples through her jiggly body.  She wields a towering whitewood staff in one hand, using the other to cast eldritch spells.";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_LOOSE);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.tallness = rand(8) + 70;
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.lowerBody = LOWER_BODY_TYPE_HARPY;
			this.skin.setBaseOnly({color:"red"});
			this.skinDesc = "feathers";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(100, 90, 160, 80);
			initLibSensCor(80, 45, 50);
			this.weaponName = "eldritch staff";
			this.weaponVerb="thwack";
			this.weaponAttack = 27 + (6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "armor";
			this.armorDef = 26 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 1000;
			this.bonusLust = 30;
			this.fatigue = 0;
			this.lust = 20;
			this.lustVuln = .15;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 30;
			this.gems = rand(25)+160;
			this.additionalXP = 50;
			this.tailType = TAIL_TYPE_HARPY;
			this.wingType = WING_TYPE_FEATHERED_LARGE;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			this.createPerk(PerkLib.Spellpower, 0, 0, 0, 0);
			this.createPerk(PerkLib.Mage, 0, 0, 0, 0);
			this.createPerk(PerkLib.ManaAffinityI, 0, 0, 0, 0);
			this.createPerk(PerkLib.MindOverBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.WizardsFocus, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.str += 30 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 27 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 48 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 24 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 24 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 6120;
			checkMonster();
		}
		
	}

}
