/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Monsters.DarkElfScene;
	
	public class DarkElfSlaver extends DarkElfScout
	{
		override public function DarkElfBowShooting():void
		{
			var Acc:Number = 0;
			Acc += (this.spe - player.spe);
			if (Acc < 0) Acc = 0;
			outputText("The black skinned elf aims her bow at you, drawing several arrows and starts shooting.\n\n");
			PoisonedBowShoot();
			if (rand(100) < (90 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (80 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (70 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
		}
		
		public function DarkElfSlaver() 
		{
			this.a = "the ";
			this.short = "dark elf slaver";
			this.imageName = "dark elf";
			this.long = "This woman with dark skin has long pointed ears. You suspect her to be a dark elf, though why she’s here on the surface, you have no idea. Regardless, she’s dangerous and seems well equipped for kidnapping.";
			this.createVagina(false, VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_SLIME_DROOLING;
			this.tallness = 72;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_LARGE+1;
			this.lowerBody = LOWER_BODY_TYPE_ELF;
			this.skinTone = "dark";
			this.hairColor = "silver";
			this.hairLength = 13;
			initStrTouSpeInte(60, 80, 140, 70);
			initLibSensCor(60, 70, 85);
			this.weaponName = "dagger";
			this.weaponVerb= "stab";
			this.weaponAttack = 5 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.weaponRangeName = "elven bow";
			this.weaponRangeVerb= "shoot";
			this.weaponRangeAttack = 24 + (5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "elven armor";
			this.armorDef = 8 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusLust = 20;
			this.lustVuln = .7;
			this.lust = 50;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 27;
			this.gems = rand(10) + 15;
			this.drop = new WeightedDrop().
					add(weaponsrange.BOWLIGH,1).
					add(consumables.ELFEARS,4);
			this.str += 18 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 24 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 42 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 18 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 3690;
			checkMonster();
		}
		
	}

}