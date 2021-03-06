/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	use namespace kGAMECLASS;
	
	public class Sonya extends Monster
	{
		public var sonyaScene:SonyaFollower = new SonyaFollower();
	/*	
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.ETNA_FOLLOWER] >= 2) etnaScene.etnaRapeIntro2();
			else if (flags[kFLAGS.ETNA_AFFECTION] > 75) etnaScene.etnaReady2Come2Camp();
			else if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] < 1 && flags[kFLAGS.ETNA_AFFECTION] > 15) etnaScene.etnaRape3rdWin();
			else etnaScene.etnaRapeIntro();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2) etnaScene.etnaRapeYandere();
			etnaScene.etnaRapesPlayer();
		}
	*/	
		public function Sonya() 
		{
			if (game.flags[kFLAGS.SONYA_TALKED_ABOUT_HER] >= 1) {
				this.a = "";
				this.short = "Sonya";
				this.long = "Sonya is twelve feet tall easily been the tallest, most muscular and feral lacta bovina you have ever seen using twin heavy hammers.";
			}
			else {
				this.a = "the ";
				this.short = "glacial bull";
				this.long = "The glacial bull is twelve feet tall, much taller and muscular than any other bull you've seen before. Additionaly it seems to be heavy corrupted havins much less human traits than other minotaurs you meet. Weirdly he seems to have his chest covered by piece of cloth too in addition to typicaly used by his brothers loincloth, but that not distracts you from the pair of large hammers it wields.";
			}
			createVagina(true,VAGINA_WETNESS_NORMAL,VAGINA_LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,60,0,0,0);
			createBreastRow(Appearance.breastCupInverse("flat"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 144;
			this.hipRating = HIP_RATING_CURVY+2;
			this.buttRating = BUTT_RATING_LARGE+1;
			this.skinTone = "light";
			this.hairColor = "red";
			this.hairLength = 1;
			initStrTouSpeInte(250, 200, 150, 180);
			initLibSensCor(50, 50, 100);
			this.weaponName = "twin hammers";
			this.weaponVerb="smash";
			this.weaponAttack = 70 + (15 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "thick fur";
			this.armorDef = 30 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 100;
			this.bonusLust = 30;
			this.lust = 30;
			this.lustVuln = .8;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 30;
			this.gems = 45 + rand(40);
			this.drop = new ChainedDrop().
				//	add(armors.S_SWMWR,1/12).
				//	add(consumables.L_DRAFT,1/4).
					add(consumables.LABOVA_,0.7);
			this.earType = EARS_COW;
			this.faceType = FACE_COW_MINOTAUR;
			this.lowerBody = LOWER_BODY_TYPE_HOOFED;
			this.tailType = TAIL_TYPE_COW;
			this.tailRecharge = 0;
			//this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			//this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.str += 75 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 60 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 45 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 54 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 15 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 9960;
			checkMonster();
		}
		
	}

}