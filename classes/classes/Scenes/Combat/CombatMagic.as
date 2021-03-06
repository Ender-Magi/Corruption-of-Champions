/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.Items.JewelryLib;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.Areas.GlacialRift.FrostGiant;
import classes.Scenes.Dungeons.D3.Doppleganger;
import classes.Scenes.Dungeons.D3.JeanClaude;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.Scenes.NPCs.Diva;
import classes.Scenes.NPCs.Holli;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.StatusEffects;

import coc.view.ButtonData;

import coc.view.ButtonDataList;

public class CombatMagic extends BaseCombatContent {
	public function CombatMagic() {
	}
	internal function applyAutocast():void {
		if (player.hasPerk(PerkLib.Spellsword) && player.lust < getWhiteMagicLustCap() && player.mana >= (spellCostWhite(30) * spellChargeWeaponCostMultiplier()) && flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] == 0 && player.weaponName != "fists") {
			spellChargeWeapon(true);
			useMana((30 * spellChargeWeaponCostMultiplier()),5);
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock(); // XXX: message?
		}
		if (player.hasPerk(PerkLib.Spellarmor) && player.lust < getWhiteMagicLustCap() && player.mana >= (spellCostWhite(40) * spellChargeArmorCostMultiplier()) && flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] == 0 && !player.isNaked()) {
			spellChargeArmor(true);
			useMana((40 * spellChargeArmorCostMultiplier()),5);
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock(); // XXX: message?
		}
		if (player.hasPerk(PerkLib.Battlemage) && ((player.hasPerk(PerkLib.GreyMage) && player.lust >= 30) || player.lust >= 50) && player.mana >= (spellCostBlack(50) * spellMightCostMultiplier()) && flags[kFLAGS.AUTO_CAST_MIGHT] == 0) {
			spellMight(true);
			useMana((50 * spellMightCostMultiplier()),6);
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock(); // XXX: message?
		}
		if (player.hasPerk(PerkLib.Battleflash) && ((player.hasPerk(PerkLib.GreyMage) && player.lust >= 30) || player.lust >= 50) && player.mana >= (spellCostBlack(40) * spellBlinkCostMultiplier()) && flags[kFLAGS.AUTO_CAST_BLINK] == 0) {
			spellBlink(true);
			useMana((40 * spellBlinkCostMultiplier()),6);
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock(); // XXX: message?
		}
	}
	internal function cleanupAfterCombatImpl():void {
		fireMagicLastTurn = -100;
		iceMagicLastTurn = -100;
		lightningMagicLastTurn = -100;
		darknessMagicLastTurn = -100;
	}
	internal function spellCostImpl(mod:Number):Number {
		//Addiditive mods
		var costPercent:Number = 100;
		if (player.hasPerk(PerkLib.SeersInsight)) costPercent -= (100 * player.perkv1(PerkLib.SeersInsight));
		if (player.hasPerk(PerkLib.SpellcastingAffinity)) costPercent -= player.perkv1(PerkLib.SpellcastingAffinity);
		if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) costPercent -= player.perkv1(PerkLib.WizardsEnduranceAndSluttySeduction);
		if (player.hasPerk(PerkLib.WizardsAndDaoistsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsAndDaoistsEndurance);
		if (player.hasPerk(PerkLib.WizardsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsEndurance);
		if (player.jewelryName == "fox hairpin") costPercent -= 20;
		if (player.weaponName == "Ascensus") costPercent -= 15;
		//Limiting it and multiplicative mods
		if(player.hasPerk(PerkLib.BloodMage) && costPercent < 50) costPercent = 50;
		mod *= costPercent/100;
		if (player.hasPerk(PerkLib.HistoryScholar) || player.hasPerk(PerkLib.PastLifeScholar)) {
			if(mod > 2) mod *= .8;
		}
		if (player.hasPerk(PerkLib.BloodMage) && mod < 5) mod = 5;
		else if(mod < 2) mod = 2;
		mod = Math.round(mod * 100)/100;
		return mod;
	}
	internal function spellCostWhiteImpl(mod:Number):Number {
		//Addiditive mods
		var costPercent:Number = 100;
		if (player.hasPerk(PerkLib.Ambition)) costPercent -= (100 * player.perkv2(PerkLib.Ambition));
		if (player.hasPerk(PerkLib.SeersInsight)) costPercent -= (100 * player.perkv1(PerkLib.SeersInsight));
		if (player.hasPerk(PerkLib.SpellcastingAffinity)) costPercent -= player.perkv1(PerkLib.SpellcastingAffinity);
		if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) costPercent -= player.perkv1(PerkLib.WizardsEnduranceAndSluttySeduction);
		if (player.hasPerk(PerkLib.WizardsAndDaoistsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsAndDaoistsEndurance);
		if (player.hasPerk(PerkLib.WizardsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsEndurance);
		if (player.jewelryName == "fox hairpin") costPercent -= 20;
		if (player.weaponName == "Puritas" || player.weaponName == "Ascensus") costPercent -= 15;
		//Limiting it and multiplicative mods
		if(player.hasPerk(PerkLib.BloodMage) && costPercent < 50) costPercent = 50;
		mod *= costPercent/100;
		if (player.hasPerk(PerkLib.HistoryScholar) || player.hasPerk(PerkLib.PastLifeScholar)) {
			if(mod > 2) mod *= .8;
		}
		if (player.hasPerk(PerkLib.BloodMage) && mod < 5) mod = 5;
		else if(mod < 2) mod = 2;
		mod = Math.round(mod * 100)/100;
		return mod;
	}
	internal function spellCostBlackImpl(mod:Number):Number {
		//Addiditive mods
		var costPercent:Number = 100;
		if (player.hasPerk(PerkLib.Obsession)) costPercent -= (100 * player.perkv2(PerkLib.Obsession));
		if (player.hasPerk(PerkLib.SeersInsight)) costPercent -= (100 * player.perkv1(PerkLib.SeersInsight));
		if (player.hasPerk(PerkLib.SpellcastingAffinity)) costPercent -= player.perkv1(PerkLib.SpellcastingAffinity);
		if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) costPercent -= player.perkv1(PerkLib.WizardsEnduranceAndSluttySeduction);
		if (player.hasPerk(PerkLib.WizardsAndDaoistsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsAndDaoistsEndurance);
		if (player.hasPerk(PerkLib.WizardsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsEndurance);
		if (player.jewelryName == "fox hairpin") costPercent -= 20;
		if (player.weaponName == "Depravatio" || player.weaponName == "Ascensus") costPercent -= 15;
		//Limiting it and multiplicative mods
		if(player.hasPerk(PerkLib.BloodMage) && costPercent < 50) costPercent = 50;
		mod *= costPercent/100;
		if (player.hasPerk(PerkLib.HistoryScholar) || player.hasPerk(PerkLib.PastLifeScholar)) {
			if(mod > 2) mod *= .8;
		}
		if (player.hasPerk(PerkLib.BloodMage) && mod < 5) mod = 5;
		else if(mod < 2) mod = 2;
		mod = Math.round(mod * 100)/100;
		return mod;
	}

	internal function spellModImpl():Number {
		var mod:Number = 1;
		if(player.hasPerk(PerkLib.Archmage) && player.inte >= 75) mod += .3;
		if(player.hasPerk(PerkLib.Channeling) && player.inte >= 60) mod += .2;
		if(player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 100) mod += .4;
		if(player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 150) mod += 1;
		if(player.hasPerk(PerkLib.GreyMage) && player.inte >= 125) mod += .7;
		if(player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) mod += .1;
		if(player.hasPerk(PerkLib.Mage) && player.inte >= 50) mod += .2;
		if(player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) mod += .1;
		if(player.hasPerk(PerkLib.TraditionalMageI) && player.weaponPerk == "Staff" && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageII) && player.weaponPerk == "Staff" && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageIII) && player.weaponPerk == "Staff" && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageIV) && player.weaponPerk == "Staff" && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageV) && player.weaponPerk == "Staff" && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageVI) && player.weaponPerk == "Staff" && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.Obsession)) {
			mod += player.perkv1(PerkLib.Obsession);
		}
		if(player.hasPerk(PerkLib.Ambition)) {
			mod += player.perkv1(PerkLib.Ambition);
		}
		if(player.hasPerk(PerkLib.WizardsFocus)) {
			mod += player.perkv1(PerkLib.WizardsFocus);
		}
		if(player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) {
			mod += player.perkv1(PerkLib.WizardsAndDaoistsFocus);
		}
		if(player.hasPerk(PerkLib.SagesKnowledge)) {
			mod += player.perkv1(PerkLib.SagesKnowledge);
		}
		if (player.hasPerk(PerkLib.ChiReflowMagic)) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.countCockSocks("blue") > 0) mod += (player.countCockSocks("blue") * .05);
		if (player.hasPerk(PerkLib.AscensionMysticality)) mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
		if (player.hasPerk(PerkLib.SeersInsight)) mod += player.perkv1(PerkLib.SeersInsight);
		if (player.shieldName == "spirit focus") mod += .2;
		if (player.shieldName == "mana bracer") mod += .5;
		if (player.weapon == weapons.ASCENSU) mod += .15;
		if (player.hasStatusEffect(StatusEffects.Maleficium)) mod += 1;
		return mod;
	}
	internal function spellModWhiteImpl():Number {
		var mod:Number = 1;
		if(player.hasPerk(PerkLib.Archmage) && player.inte >= 75) mod += .3;
		if(player.hasPerk(PerkLib.Channeling) && player.inte >= 60) mod += .2;
		if(player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 100) mod += .4;
		if(player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 150) mod += 1;
		if(player.hasPerk(PerkLib.GreyMage) && player.inte >= 125) mod += .7;
		if(player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) mod += .1;
		if(player.hasPerk(PerkLib.Mage) && player.inte >= 50) mod += .2;
		if(player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) mod += .1;
		if(player.hasPerk(PerkLib.TraditionalMageI) && player.weaponPerk == "Staff" && player.weaponRangeName == "nothing") mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageII) && player.weaponPerk == "Staff" && player.weaponRangeName == "nothing") mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageIII) && player.weaponPerk == "Staff" && player.weaponRangeName == "nothing") mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageIV) && player.weaponPerk == "Staff" && player.weaponRangeName == "nothing") mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageV) && player.weaponPerk == "Staff" && player.weaponRangeName == "nothing") mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageVI) && player.weaponPerk == "Staff" && player.weaponRangeName == "nothing") mod += 1;
		if(player.hasPerk(PerkLib.Ambition)) {
			mod += player.perkv2(PerkLib.Ambition);
		}
		if(player.hasStatusEffect(StatusEffects.BlessingOfDivineMarae)) {
			mod += player.statusEffectv2(StatusEffects.BlessingOfDivineMarae);
		}
		if(player.hasPerk(PerkLib.WizardsFocus)) {
			mod += player.perkv1(PerkLib.WizardsFocus);
		}
		if(player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) {
			mod += player.perkv1(PerkLib.WizardsAndDaoistsFocus);
		}
		if(player.hasPerk(PerkLib.SagesKnowledge)) {
			mod += player.perkv1(PerkLib.SagesKnowledge);
		}
		if (player.hasPerk(PerkLib.ChiReflowMagic)) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.countCockSocks("blue") > 0) mod += (player.countCockSocks("blue") * .05);
		if (player.hasPerk(PerkLib.AscensionMysticality)) mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
		if (player.hasPerk(PerkLib.SeersInsight)) mod += player.perkv1(PerkLib.SeersInsight);
		if (player.shieldName == "spirit focus") mod += .2;
		if (player.shieldName == "mana bracer") mod += .5;
		if (player.weapon == weapons.PURITAS || player.weapon == weapons.ASCENSU) mod += .15;
		if (player.hasStatusEffect(StatusEffects.Maleficium)) mod += 1;
		return mod;
	}
	internal function spellModBlackImpl():Number {
		var mod:Number = 1;
		if(player.hasPerk(PerkLib.Archmage) && player.inte >= 75) mod += .3;
		if(player.hasPerk(PerkLib.Channeling) && player.inte >= 60) mod += .2;
		if(player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 100) mod += .4;
		if(player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 150) mod += 1;
		if(player.hasPerk(PerkLib.GreyMage) && player.inte >= 125) mod += .7;
		if(player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) mod += .1;
		if(player.hasPerk(PerkLib.Mage) && player.inte >= 50) mod += .2;
		if(player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) mod += .1;
		if(player.hasPerk(PerkLib.TraditionalMageI) && player.weaponPerk == "Staff" && player.weaponRangeName == "nothing") mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageII) && player.weaponPerk == "Staff" && player.weaponRangeName == "nothing") mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageIII) && player.weaponPerk == "Staff" && player.weaponRangeName == "nothing") mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageIV) && player.weaponPerk == "Staff" && player.weaponRangeName == "nothing") mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageV) && player.weaponPerk == "Staff" && player.weaponRangeName == "nothing") mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageVI) && player.weaponPerk == "Staff" && player.weaponRangeName == "nothing") mod += 1;
		if(player.hasPerk(PerkLib.Obsession)) {
			mod += player.perkv2(PerkLib.Obsession);
		}
		if(player.hasPerk(PerkLib.WizardsFocus)) {
			mod += player.perkv1(PerkLib.WizardsFocus);
		}
		if(player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) {
			mod += player.perkv1(PerkLib.WizardsAndDaoistsFocus);
		}
		if(player.hasPerk(PerkLib.SagesKnowledge)) {
			mod += player.perkv1(PerkLib.SagesKnowledge);
		}
		if (player.hasPerk(PerkLib.ChiReflowMagic)) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.countCockSocks("blue") > 0) mod += (player.countCockSocks("blue") * .05);
		if (player.hasPerk(PerkLib.AscensionMysticality)) mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
		if (player.hasPerk(PerkLib.SeersInsight)) mod += player.perkv1(PerkLib.SeersInsight);
		if (player.shieldName == "spirit focus") mod += .2;
		if (player.shieldName == "mana bracer") mod += .5;
		if (player.weapon == weapons.DEPRAVA || player.weapon == weapons.ASCENSU) mod += .15;
		if (player.hasStatusEffect(StatusEffects.Maleficium)) mod += 1;
		return mod;
	}
	
	public function spellMightCostMultiplier():Number {
		var spellMightMultiplier:Number = 1;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) spellMightMultiplier *= 2;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) spellMightMultiplier *= 2;
		return spellMightMultiplier;
	}

	public function spellBlinkCostMultiplier():Number {
		var spellBlinkMultiplier:Number = 1;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) spellBlinkMultiplier *= 2;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) spellBlinkMultiplier *= 2;
		return spellBlinkMultiplier;
	}

	public function spellChargeWeaponCostMultiplier():Number {
		var spellChargeWeaponMultiplier:Number = 1;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) spellChargeWeaponMultiplier *= 2;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) spellChargeWeaponMultiplier *= 2;
		return spellChargeWeaponMultiplier;
	}

	public function spellChargeArmorCostMultiplier():Number {
		var spellChargeArmorMultiplier:Number = 1;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) spellChargeArmorMultiplier *= 2;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) spellChargeArmorMultiplier *= 2;
		return spellChargeArmorMultiplier;
	}

	public function getBlackMagicMinLust():Number {
		if (player.hasPerk(PerkLib.GreyMage)) return 30;
		return 50;
	}
	public function getWhiteMagicLustCap():Number {
		var whiteLustCap:int = player.maxLust() * 0.75;
		if (player.hasPerk(PerkLib.Enlightened) && player.cor < (10 + player.corruptionTolerance())) whiteLustCap += (player.maxLust() * 0.1);
		if (player.hasPerk(PerkLib.FocusedMind) && !player.hasPerk(PerkLib.GreyMage)) whiteLustCap += (player.maxLust() * 0.1);
		if (player.hasPerk(PerkLib.GreyMage)) whiteLustCap = (player.maxLust() - 45);
		if (player.hasPerk(PerkLib.GreyMage) && player.hasPerk(PerkLib.Enlightened) && player.cor < (10 + player.corruptionTolerance())) whiteLustCap = (player.maxLust() - 15);
		return whiteLustCap;
	}


	private var fireMagicLastTurn:int = -100;
	private var fireMagicCumulated:int = 0;
	internal function calcInfernoModImpl(damage:Number):int {
		if (player.hasPerk(PerkLib.RagingInferno)) {
			var multiplier:Number = 1;
			if (combatRound - fireMagicLastTurn == 2) {
				outputText("Traces of your previously used fire magic are still here, and you use them to empower another spell!\n\n");
				switch(fireMagicCumulated) {
					case 0:
					case 1:
						multiplier = 1;
						break;
					case 2:
						multiplier = 1.2;
						break;
					case 3:
						multiplier = 1.35;
						break;
					case 4:
						multiplier = 1.45;
						break;
					default:
						multiplier = 1.5 + ((fireMagicCumulated - 5) * 0.05); //Diminishing returns at max, add 0.05 to multiplier.
				}
				damage = Math.round(damage * multiplier);
				fireMagicCumulated++;
				// XXX: Message?
			} else {
				if (combatRound - fireMagicLastTurn > 2 && fireMagicLastTurn > 0)
					outputText("Unfortunately, traces of your previously used fire magic are too weak to be used.\n\n");
				fireMagicCumulated = 1;
			}
			fireMagicLastTurn = combatRound;
		}
		return damage;
	}

	private var iceMagicLastTurn:int = -100;
	private var iceMagicCumulated:int = 0;
	internal function calcGlacialModImpl(damage:Number):int {
		if (player.hasPerk(PerkLib.GlacialStorm)) {
			var multiplier:Number = 1;
			if (combatRound - iceMagicLastTurn == 2) {
				outputText("Traces of your previously used ice magic are still here, and you use them to empower another spell!\n\n");
				switch(iceMagicCumulated) {
					case 0:
					case 1:
						multiplier = 1;
						break;
					case 2:
						multiplier = 1.2;
						break;
					case 3:
						multiplier = 1.35;
						break;
					case 4:
						multiplier = 1.45;
						break;
					default:
						multiplier = 1.5 + ((iceMagicCumulated - 5) * 0.05); //Diminishing returns at max, add 0.05 to multiplier.
				}
				damage = Math.round(damage * multiplier);
				iceMagicCumulated++;
				// XXX: Message?
			} else {
				if (combatRound - iceMagicLastTurn > 2 && iceMagicLastTurn > 0)
					outputText("Unfortunately, traces of your previously used ice magic are too weak to be used.\n\n");
				iceMagicCumulated = 1;
			}
			iceMagicLastTurn = combatRound;
		}
		return damage;
	}

	private var lightningMagicLastTurn:int = -100;
	private var lightningMagicCumulated:int = 0;
	internal function calcVoltageModImpl(damage:Number):int {
		if (player.hasPerk(PerkLib.HighVoltage)) {
			var multiplier:Number = 1;
			if (combatRound - lightningMagicLastTurn == 2) {
				outputText("Traces of your previously used lightning magic are still here, and you use them to empower another spell!\n\n");
				switch(lightningMagicCumulated) {
					case 0:
					case 1:
						multiplier = 1;
						break;
					case 2:
						multiplier = 1.2;
						break;
					case 3:
						multiplier = 1.35;
						break;
					case 4:
						multiplier = 1.45;
						break;
					default:
						multiplier = 1.5 + ((lightningMagicCumulated - 5) * 0.05); //Diminishing returns at max, add 0.05 to multiplier.
				}
				damage = Math.round(damage * multiplier);
				lightningMagicCumulated++;
				// XXX: Message?
			} else {
				if (combatRound - lightningMagicLastTurn > 2 && lightningMagicLastTurn > 0)
					outputText("Unfortunately, traces of your previously used lightning magic are too weak to be used.\n\n");
				lightningMagicCumulated = 1;
			}
			lightningMagicLastTurn = combatRound;
		}
		return damage;
	}

	private var darknessMagicLastTurn:int = -100;
	private var darknessMagicCumulated:int = 0;
	internal function calcEclypseModImpl(damage:Number):int {
		if (player.hasPerk(PerkLib.EclipsingShadow)) {
			var multiplier:Number = 1;
			if (combatRound - darknessMagicLastTurn == 2) {
				outputText("Traces of your previously used darkness magic are still here, and you use them to empower another spell!\n\n");
				switch(darknessMagicCumulated) {
					case 0:
					case 1:
						multiplier = 1;
						break;
					case 2:
						multiplier = 1.2;
						break;
					case 3:
						multiplier = 1.35;
						break;
					case 4:
						multiplier = 1.45;
						break;
					default:
						multiplier = 1.5 + ((darknessMagicCumulated - 5) * 0.05); //Diminishing returns at max, add 0.05 to multiplier.
				}
				damage = Math.round(damage * multiplier);
				darknessMagicCumulated++;
				// XXX: Message?
			} else {
				if (combatRound - darknessMagicLastTurn > 2 && darknessMagicLastTurn > 0)
					outputText("Unfortunately, traces of your previously used darkness magic are too weak to be used.\n\n");
				darknessMagicCumulated = 1;
			}
			darknessMagicLastTurn = combatRound;
		}
		return damage;
	}
	
	internal function buildMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		
		var badLustForWhite:Boolean        = player.lust >= getWhiteMagicLustCap();
		var badLustForBlack:Boolean        = player.lust < getBlackMagicMinLust();
		var badLustForGrey:Boolean         = player.lust < 50 || player.lust > (player.maxLust() - 50);
		//WHITE SHITZ
		if (player.hasStatusEffect(StatusEffects.KnowsBlind)) {
			bd = buttons.add("Blind", spellBlind)
						.hint("Blind is a fairly self-explanatory spell.  It will create a bright flash just in front of the victim's eyes, blinding them for a time.  However if they blink it will be wasted.  " +
							  "\n\nMana Cost: " + spellCostWhite(30) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (monster.hasStatusEffect(StatusEffects.Blind)) {
				bd.disable(monster.capitalA + monster.short + " is already affected by blind.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(30)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(30) && player.HP < spellCostWhite(30)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsWhitefire)) {
			bd = buttons.add("Whitefire", spellWhitefire)
						.hint("Whitefire is a potent fire based attack that will burn your foe with flickering white flames, ignoring their physical toughness and most armors.  " +
							  "\n\nMana Cost: " + spellCostWhite(40) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40) && player.HP < spellCostWhite(40)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
			
		}
		if (player.hasStatusEffect(StatusEffects.KnowsLightningBolt)) {
			bd = buttons.add("LightningBolt", spellLightningBolt)
						.hint("Lightning Bolt is a basic lightning attack that will electrocute your foe with a single bolt of lightning.  " +
							  "\n\nMana Cost: " + spellCostWhite(40) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40) && player.HP < spellCostWhite(40)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsCharge)) {
			bd = buttons.add("Charge W.", spellChargeWeapon)
						.hint("The Charge Weapon spell will surround your weapon in electrical energy, causing it to do even more damage.  The effect lasts for a few combat turns.  " +
							  "\n\nMana Cost: " + spellCostWhite(30) * spellChargeWeaponCostMultiplier() + "", "Charge Weapon");
			if (player.weaponName == "fists" && !player.hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalWeapons)) {
				bd.disable("Charge weapon can't be casted on your own fists.");
			} else if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (player.hasStatusEffect(StatusEffects.ChargeWeapon)){
				bd.disable("Charge weapon is already active and cannot be cast again.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostWhite(30) * spellChargeWeaponCostMultiplier())) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostWhite(30) * spellChargeWeaponCostMultiplier()) && player.HP < (spellCostWhite(30) * spellChargeWeaponCostMultiplier())) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsChargeA)) {
			bd = buttons.add("Charge A.", spellChargeArmor)
						.hint("The Charge Armor spell will surround your armor with electrical energy, causing it to do provide additional protection.  The effect lasts for a few combat turns.  " +
							  "\n\nMana Cost: " + spellCostWhite(40) * spellChargeArmorCostMultiplier() + "", "Charge Armor");
			if (player.isNaked() && (!player.haveNaturalArmor() || player.hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor))) {
				bd.disable("Charge armor can't be casted without wearing any armor or even underwear.");
			} else if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (player.hasStatusEffect(StatusEffects.ChargeArmor)) {
				bd.disable("Charge armor is already active and cannot be cast again.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostWhite(40) * spellChargeArmorCostMultiplier())) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostWhite(40) * spellChargeArmorCostMultiplier()) && player.HP < (spellCostWhite(40) * spellChargeArmorCostMultiplier())) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBlizzard)) {
			bd = buttons.add("Blizzard", spellBlizzard)
						.hint("Blizzard is a potent ice based defense spell that will reduce power of any fire based attack used against the user.  " +
							  "\n\nMana Cost: " + spellCostWhite(50) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				bd.disable("Blizzard is already active and cannot be cast again.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(50)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(50) && player.HP < spellCostWhite(50)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		
		//BLACK MAGICSKS
		if (player.hasStatusEffect(StatusEffects.KnowsArouse)) {
			bd = buttons.add("Arouse", spellArouse)
						.hint("The arouse spell draws on your own inner lust in order to enflame the enemy's passions.  " +
							  "\n\nMana Cost: " + spellCostBlack(20) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if (!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(20)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(20) && player.HP < spellCostBlack(20)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsHeal)) {
			bd = buttons.add("Heal", spellHeal)
						.hint("Heal will attempt to use black magic to close your wounds and restore your body, however like all black magic used on yourself, it has a chance of backfiring and greatly arousing you.  " +
							  "\n\nMana Cost: " + spellCostBlack(30) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if(/*!player.hasPerk(PerkLib.BloodMage) && */player.mana < spellCostWhite(30)) {
				bd.disable("Your mana is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsIceSpike)) {
			bd = buttons.add("Ice Spike", spellIceSpike)
						.hint("Drawning your own lust to concentrate it into chilling spike of ice that will attack your enemies.  " +
							  "\n\nMana Cost: " + spellCostBlack(40) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40) && player.HP < spellCostBlack(40)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsDarknessShard)) {
			bd = buttons.add("DarknessShard", spellDarknessShard)
						.hint("Drawning your own lust to condense part of the the ambivalent darkness into a shard to attack your enemies.  " +
							  "\n\nMana Cost: " + spellCostBlack(40) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40) && player.HP < spellCostBlack(40)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsMight)) {
			bd = buttons.add("Might", spellMight)
						.hint("The Might spell draws upon your lust and uses it to fuel a temporary increase in muscle size and power.  It does carry the risk of backfiring and raising lust, like all black magic used on oneself.  " +
							  "\n\nMana Cost: " + spellCostBlack(50) * spellMightCostMultiplier() + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if (player.hasStatusEffect(StatusEffects.Might)) {
				bd.disable("You are already under the effects of Might and cannot cast it again.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostBlack(50) * spellMightCostMultiplier())) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostBlack(50) * spellMightCostMultiplier()) && player.HP < (spellCostBlack(50) * spellMightCostMultiplier())) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBlink)) {
			bd= buttons.add("Blink", spellBlink)
					   .hint("The Blink spell draws upon your lust and uses it to fuel a temporary increase in moving speed and if it's needed teleport over short distances.  It does carry the risk of backfiring and raising lust, like all black magic used on oneself.  " +
							 "\n\nMana Cost: " + spellCostBlack(40) * spellBlinkCostMultiplier() + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if (player.hasStatusEffect(StatusEffects.Blink)) {
				bd.disable("You are already under the effects of Blink and cannot cast it again.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostBlack(40) * spellBlinkCostMultiplier())) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostBlack(40) * spellBlinkCostMultiplier()) && player.HP < (spellCostBlack(40) * spellBlinkCostMultiplier())) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		
		// GRAY MAGIC
		//	if (player.hasStatusEffect(StatusEffects.Knows)) buttons.add("	1st spell (non-fire or non-ice based) goes here
		if (player.hasStatusEffect(StatusEffects.KnowsManaShield)) {
			if (player.hasStatusEffect(StatusEffects.ManaShield)) {
				buttons.add("Deactiv MS", DeactivateManaShield).hint("Deactivate Mana Shield.\n");
			} else {
				bd = buttons.add("Mana Shield", ManaShield)
						.hint("Drawning your own mana with help of lust and force of the willpower to form shield that can absorb attacks.  Despite been grey magic it still does carry the risk of backfiring and raising lust.  \n\nMana Cost: 1 mana point per 1 point of damage blocked");
				if (badLustForGrey) {
					bd.disable("You can't use any grey magics.");
				}
			}
		}
		//	if (player.hasStatusEffect(StatusEffects.KnowsWereBeast)) buttons.add("Were-beast",	were-beast spell goes here
		if (player.hasStatusEffect(StatusEffects.KnowsFireStorm)) {
			bd = buttons.add("Fire Storm", spellFireStorm).hint("Drawning your own lust and force of the willpower to fuel radical change in the surrounding you can call forth an Fire Storm that will attack enemies in a wide area.  Despite been grey magic it still does carry the risk of backfiring and raising lust.  \n\n<b>AoE Spell.</b>  \n\nMana Cost: " + spellCost(200) + "");
			if (badLustForGrey) {
				bd.disable("You can't use any grey magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200) && player.HP < spellCost(200)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		//	if (player.hasStatusEffect(StatusEffects.Knows)) buttons.add("	fire single target spell goes here
		if (player.hasStatusEffect(StatusEffects.KnowsIceRain)) {
			bd = buttons.add("Ice Rain", spellIceRain).hint("Drawning your own lust and force of the willpower to fuel radical change in the surrounding you can call forth an Ice Rain that will attack enemies in a wide area.  Despite been grey magic it still does carry the risk of backfiring and raising lust.  \n\n<b>AoE Spell.</b>  \n\nMana Cost: " + spellCost(200) + "");
			if (badLustForGrey) {
				bd.disable("You can't use any grey magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200) && player.HP < spellCost(200)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		//	if (player.hasStatusEffect(StatusEffects.Knows)) buttons.add("	ice single target spell goes here
		
	}
	
	public function spellArouse():void {
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(20)) player.HP -= spellCostBlack(20);
		else useMana(20,6);
		statScreenRefresh();
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			enemyAI();
			return;
		}
		if(handleShell()){return;}
		outputText("You make a series of arcane gestures, drawing on your own lust to inflict it upon your foe!\n");
		//Worms be immune
		if(monster.short == "worms") {
			outputText("The worms appear to be unaffected by your magic!");
			outputText("\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			doNext(playerMenu);
			if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
			else enemyAI();
			return;
		}
		if(monster.lustVuln == 0) {
			outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			enemyAI();
			return;
		}
		var lustDmg:Number = monster.lustVuln * (player.inte / 5 * spellModBlack() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
		if(player.hasPerk(PerkLib.ArcaneLash)) lustDmg *= 1.5;
		if(monster.lust < (monster.maxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
		if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if(monster.lust >= (monster.maxLust() * 0.6)) {
			outputText(monster.capitalA + monster.short + "'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		if(monster.cocks.length > 0) {
			if(monster.lust >= (monster.maxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if(monster.vaginas.length > 0) {
			if(monster.plural) {
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		//Determine if critical tease!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.CriticalPerformance)) {
			if (player.lib <= 100) critChance += player.lib / 5;
			if (player.lib > 100) critChance += 20;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			lustDmg *= 1.75;
		}
		lustDmg = Math.round(lustDmg);
		monster.teased(lustDmg);
		if (crit == true) outputText(" <b>Critical!</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		doNext(playerMenu);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
		else enemyAI();
	}
	public function spellHeal():void {
		clearOutput();
		doNext(combatMenu);
		useMana(30, 8);
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			enemyAI();
			return;
		}
		outputText("You focus on your body and its desire to end pain, trying to draw on your arousal without enhancing it.\n");
		//30% backfire!
		var backfire:int = 30;
		if (player.hasPerk(PerkLib.FocusedMind)) backfire = 20;
		backfire -= (player.inte * 0.15);
		if (backfire < 15) backfire = 15;
		else if (backfire < 5 && player.hasPerk(PerkLib.FocusedMind)) backfire = 5;
		if(rand(100) < backfire) {
			outputText("An errant sexual thought crosses your mind, and you lose control of the spell!  Your ");
			if(player.gender == 0) outputText(assholeDescript() + " tingles with a desire to be filled as your libido spins out of control.");
			if(player.gender == 1) {
				if(player.cockTotal() == 1) outputText(player.cockDescript(0) + " twitches obscenely and drips with pre-cum as your libido spins out of control.");
				else outputText(player.multiCockDescriptLight() + " twitch obscenely and drip with pre-cum as your libido spins out of control.");
			}
			if(player.gender == 2) outputText(vaginaDescript(0) + " becomes puffy, hot, and ready to be touched as the magic diverts into it.");
			if(player.gender == 3) outputText(vaginaDescript(0) + " and [cocks] overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.");
			dynStats("lib", .25, "lus", 15);
		}
		else spellHealEffect();
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}

	public function spellHealEffect():void {
		temp = 0;
		temp += inteligencescalingbonus();
		temp *= spellModBlack();
		if (player.unicornScore() >= 5) temp *= ((player.unicornScore() - 4) * 0.5);
		if (player.alicornScore() >= 6) temp *= ((player.alicornScore() - 5) * 0.5);
		if (player.armorName == "skimpy nurse's outfit") temp *= 1.2;
		//Determine if critical heal!
		var crit:Boolean = false;
		var critHeal:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critHeal += (player.inte - 50) / 50;
			if (player.inte > 100) critHeal += 10;
		}
		if (rand(100) < critHeal) {
			crit = true;
			temp *= 1.75;
		}
		temp = Math.round(temp);
		outputText("You flush with success as your wounds begin to knit <b>(<font color=\"#008000\">+" + temp + "</font>)</b>.");
		if (crit == true) outputText(" <b>*Critical Heal!*</b>");
		HPChange(temp,false);
	}
	/**
	 * Generates from (x1,x2,x3,y1,y2) log-scale parameters (a,b,c) that will return:
	 * y1= 10 at x1=  10
	 * y2= 55 at x2= 100
	 * y3=100 at x3=1000
	 */
	private static const MightABC:Object = FnHelpers.FN.buildLogScaleABC(10,100,1000,10,100);
//(25) Might – increases strength/toughness by 5 * (Int / 10) * spellMod, up to a
//maximum of 15, allows it to exceed the maximum.  Chance of backfiring
//and increasing lust by 15.
	public function spellMight(silent:Boolean = false):void {

		var doEffect:Function = function():* {
			var MightBoost:Number = 10;
			if (player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) MightBoost += 5;
			if (player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) MightBoost += 5;
			if (player.hasPerk(PerkLib.Mage) && player.inte >= 50) MightBoost += 10;
			if (player.hasPerk(PerkLib.FocusedMind) && player.inte >= 50) MightBoost += 10;
			if (player.hasPerk(PerkLib.Channeling) && player.inte >= 60) MightBoost += 10;
			if (player.hasPerk(PerkLib.Archmage) && player.inte >= 75) MightBoost += 15;
			if (player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 100) MightBoost += 20;
			if (player.hasPerk(PerkLib.GreyMage) && player.inte >= 125) MightBoost += 25;
			if (player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 150) MightBoost += 30;
			if (player.hasPerk(PerkLib.JobEnchanter) && player.inte >= 50) MightBoost += 5;
			if (player.hasPerk(PerkLib.Battlemage) && player.inte >= 50) MightBoost += 15;
			if (player.hasPerk(PerkLib.JobBarbarian)) MightBoost -= 10;
			if (player.hasPerk(PerkLib.JobBrawler)) MightBoost -= 10;
			if (player.hasPerk(PerkLib.JobDervish)) MightBoost -= 10;
			if (player.hasPerk(PerkLib.IronFistsI)) MightBoost -= 10;
			if (player.hasPerk(PerkLib.JobMonk)) MightBoost -= 15;
			if (player.hasPerk(PerkLib.Berzerker)) MightBoost -= 15;
			if (player.hasPerk(PerkLib.Lustzerker)) MightBoost -= 15;
			if (player.hasPerk(PerkLib.WeaponMastery)) MightBoost -= 15;
			if (player.hasPerk(PerkLib.WeaponGrandMastery)) MightBoost -= 25;
			if (player.hasPerk(PerkLib.HeavyArmorProficiency)) MightBoost -= 15;
			if (player.hasPerk(PerkLib.AyoArmorProficiency)) MightBoost -= 20;
			if (player.hasPerk(PerkLib.Agility)) MightBoost -= 10;
			if (player.hasPerk(PerkLib.LightningStrikes)) MightBoost -= 10;
			if (player.hasPerk(PerkLib.BodyCultivator)) MightBoost -= 5;
		//	MightBoost += player.inte / 10;player.inte * 0.1 - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells
			if (MightBoost < 10) MightBoost = 10;
			if (player.hasPerk(PerkLib.JobEnchanter)) MightBoost *= 1.2;
			MightBoost *= spellModBlack();
			MightBoost = FnHelpers.FN.logScale(MightBoost,MightABC,10);
			MightBoost = Math.round(MightBoost);
			var MightDuration:Number = 5;
			if (player.hasPerk(PerkLib.LongerLastingBuffsI)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsII)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsIII)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsIV)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsV)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsVI)) MightDuration += 1;
			if (player.hasPerk(PerkLib.EverLastingBuffs)) MightDuration += 5;
			if (player.hasPerk(PerkLib.EternalyLastingBuffs)) MightDuration += 5;
			tempTou = MightBoost;
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) {
				var MightIntBoost:Number = 0;
				MightIntBoost += 25 * spellModBlack() * (1 + player.newGamePlusMod());
				tempInt = MightIntBoost;
			} else {
				tempStr = MightBoost;
			}
			var oldHPratio:Number = player.hp100/100;
			player.createStatusEffect(StatusEffects.Might,0,0,MightDuration,0);
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) player.changeStatusValue(StatusEffects.Might,1,tempInt);
			else player.changeStatusValue(StatusEffects.Might,1,tempStr);
			player.changeStatusValue(StatusEffects.Might,2,tempTou);
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) {
				player.inte += player.statusEffectv1(StatusEffects.Might);
			} else {
				player.str += player.statusEffectv1(StatusEffects.Might);
			}
			player.tou += player.statusEffectv2(StatusEffects.Might);
			player.HP = oldHPratio*player.maxHP();
			statScreenRefresh();
		};

		if (silent)	{ // for Battlemage
			doEffect.call();
			return;
		}

		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < (50 * spellMightCostMultiplier())) player.HP -= (50 * spellMightCostMultiplier());
		else useMana((50 * spellMightCostMultiplier()),6);
		var tempStr:Number = 0;
		var tempTou:Number = 0;
		var tempInt:Number = 0;
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			enemyAI();
			return;
		}
		outputText("You flush, drawing on your body's desires to empower your muscles and toughen you up.\n\n");
		//30% backfire!
		var backfire:int = 30;
		if (player.hasPerk(PerkLib.FocusedMind)) backfire = 20;
		if (backfire < 15) backfire = 15;
		else if (backfire < 5 && player.hasPerk(PerkLib.FocusedMind)) backfire = 5;
		if(rand(100) < backfire) {
			outputText("An errant sexual thought crosses your mind, and you lose control of the spell!  Your ");
			if(player.gender == 0) outputText(assholeDescript() + " tingles with a desire to be filled as your libido spins out of control.");
			if(player.gender == 1) {
				if(player.cockTotal() == 1) outputText(player.cockDescript(0) + " twitches obscenely and drips with pre-cum as your libido spins out of control.");
				else outputText(player.multiCockDescriptLight() + " twitch obscenely and drip with pre-cum as your libido spins out of control.");
			}
			if(player.gender == 2) outputText(vaginaDescript(0) + " becomes puffy, hot, and ready to be touched as the magic diverts into it.");
			if(player.gender == 3) outputText(vaginaDescript(0) + " and [cocks] overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.");
			dynStats("lib", .25, "lus", 15);
		}
		else {
			outputText("The rush of success and power flows through your body.  You feel like you can do anything!");
			doEffect.call();
		}
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}

	/**
	 * Generates from (x1,x2,x3,y1,y2) log-scale parameters (a,b,c) that will return:
	 * y1= 10 at x1=  10
	 * y2= 55 at x2= 100
	 * y3=100 at x3=1000
	 */
	private static const BlinkABC:Object = FnHelpers.FN.buildLogScaleABC(10,100,1000,10,100);
//(25) Blink – increases speed by 5 * (Int / 10) * spellMod, up to a
//maximum of 15, allows it to exceed the maximum.  Chance of backfiring
//and increasing lust by 15.
	public function spellBlink(silent:Boolean = false):void {

		var doEffect:Function = function():* {
			var BlinkBoost:Number = 10;
			if (player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) BlinkBoost += 5;
			if (player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) BlinkBoost += 5;
			if (player.hasPerk(PerkLib.Mage) && player.inte >= 50) BlinkBoost += 10;
			if (player.hasPerk(PerkLib.FocusedMind) && player.inte >= 50) BlinkBoost += 10;
			if (player.hasPerk(PerkLib.Channeling) && player.inte >= 60) BlinkBoost += 10;
			if (player.hasPerk(PerkLib.Archmage) && player.inte >= 75) BlinkBoost += 15;
			if (player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 100) BlinkBoost += 20;
			if (player.hasPerk(PerkLib.GreyMage) && player.inte >= 125) BlinkBoost += 25;
			if (player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 150) BlinkBoost += 30;
			if (player.hasPerk(PerkLib.JobEnchanter) && player.inte >= 50) BlinkBoost += 5;
			if (player.hasPerk(PerkLib.Battleflash) && player.inte >= 50) BlinkBoost += 15;
			if (player.hasPerk(PerkLib.JobBarbarian)) BlinkBoost -= 10;
			if (player.hasPerk(PerkLib.JobBrawler)) BlinkBoost -= 10;
			if (player.hasPerk(PerkLib.JobDervish)) BlinkBoost -= 10;
			if (player.hasPerk(PerkLib.IronFistsI)) BlinkBoost -= 10;
			if (player.hasPerk(PerkLib.JobMonk)) BlinkBoost -= 15;
			if (player.hasPerk(PerkLib.Berzerker)) BlinkBoost -= 15;
			if (player.hasPerk(PerkLib.Lustzerker)) BlinkBoost -= 15;
			if (player.hasPerk(PerkLib.WeaponMastery)) BlinkBoost -= 15;
			if (player.hasPerk(PerkLib.WeaponGrandMastery)) BlinkBoost -= 25;
			if (player.hasPerk(PerkLib.HeavyArmorProficiency)) BlinkBoost -= 15;
			if (player.hasPerk(PerkLib.AyoArmorProficiency)) BlinkBoost -= 20;
			if (player.hasPerk(PerkLib.Agility)) BlinkBoost -= 10;
			if (player.hasPerk(PerkLib.LightningStrikes)) BlinkBoost -= 10;
			if (player.hasPerk(PerkLib.BodyCultivator)) BlinkBoost -= 5;
		//	BlinkBoost += player.inte / 10;player.inte * 0.1 - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells
			if (BlinkBoost < 10) BlinkBoost = 10;
			BlinkBoost *= 1.2;
			if (player.hasPerk(PerkLib.JobEnchanter)) BlinkBoost *= 1.25;
			BlinkBoost *= spellModBlack();
			BlinkBoost = FnHelpers.FN.logScale(BlinkBoost,BlinkABC,10);
			BlinkBoost = Math.round(BlinkBoost);
			var BlinkDuration:Number = 5;
			if (player.hasPerk(PerkLib.LongerLastingBuffsI)) BlinkDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsII)) BlinkDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsIII)) BlinkDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsIV)) BlinkDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsV)) BlinkDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsVI)) BlinkDuration += 1;
			if (player.hasPerk(PerkLib.EverLastingBuffs)) BlinkDuration += 5;
			if (player.hasPerk(PerkLib.EternalyLastingBuffs)) BlinkDuration += 5;
			player.createStatusEffect(StatusEffects.Blink,0,0,BlinkDuration,0);
			temp = BlinkBoost;
			tempSpe = temp;
			//if(player.spe + temp > 100) tempSpe = 100 - player.spe;
			player.changeStatusValue(StatusEffects.Blink,1,tempSpe);
			mainView.statsView.showStatUp('spe');
			// strUp.visible = true;
			// strDown.visible = false;
			player.spe += player.statusEffectv1(StatusEffects.Blink);
			statScreenRefresh();
		};

		if (silent)	{ // for Battleflash
			doEffect.call();
			return;
		}

		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < (40 * spellBlinkCostMultiplier())) player.HP -= (40 * spellBlinkCostMultiplier());
		else useMana((40 * spellBlinkCostMultiplier()),6);
		var tempSpe:Number = 0;
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			enemyAI();
			return;
		}
		outputText("You flush, drawing on your body's desires to empower your muscles and hasten you up.\n\n");
		//30% backfire!
		var backfire:int = 30;
		if (player.hasPerk(PerkLib.FocusedMind)) backfire = 20;
		if (backfire < 15) backfire = 15;
		else if (backfire < 5 && player.hasPerk(PerkLib.FocusedMind)) backfire = 5;
		if(rand(100) < backfire) {
			outputText("An errant sexual thought crosses your mind, and you lose control of the spell!  Your ");
			if(player.gender == 0) outputText(assholeDescript() + " tingles with a desire to be filled as your libido spins out of control.");
			if(player.gender == 1) {
				if(player.cockTotal() == 1) outputText(player.cockDescript(0) + " twitches obscenely and drips with pre-cum as your libido spins out of control.");
				else outputText(player.multiCockDescriptLight() + " twitch obscenely and drip with pre-cum as your libido spins out of control.");
			}
			if(player.gender == 2) outputText(vaginaDescript(0) + " becomes puffy, hot, and ready to be touched as the magic diverts into it.");
			if(player.gender == 3) outputText(vaginaDescript(0) + " and [cocks] overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.");
			dynStats("lib", .25, "lus", 15);
		}
		else {
			outputText("The rush of success and power flows through your body.  You feel like you can do anything!");
			doEffect.call();
		}
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}

//(45) Ice Spike - ice version of whitefire
	public function spellIceSpike():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40)) player.HP -= spellCostBlack(40);
		else useMana(40,6);
		if(handleShell()){return;}
		//if (monster is Doppleganger)
		//{
		//(monster as Doppleganger).handleSpellResistance("whitefire");
		//flags[kFLAGS.SPELLS_CAST]++;
		//if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		//spellPerkUnlock();
		//return;
		//}
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You narrow your eyes, focusing your own lust with deadly intent.  At the palm of your hand form ice spike that shots toward " + monster.a + monster.short + " !\n");
		temp = 0;
		temp += inteligencescalingbonus();
		temp *= spellModBlack();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			temp *= 1.75;
		}
		//High damage to goes.
		temp = calcGlacialMod(temp);
		if (monster.hasPerk(PerkLib.IceNature)) temp *= 0.2;
		if (monster.hasPerk(PerkLib.FireVulnerability)) temp *= 0.5;
		if (monster.hasPerk(PerkLib.IceVulnerability)) temp *= 2;
		if (monster.hasPerk(PerkLib.FireNature)) temp *= 5;
		if (player.hasPerk(PerkLib.ColdMastery)) temp *= 2;
		if (player.hasPerk(PerkLib.ColdAffinity)) temp *= 2;
		temp = Math.round(temp);
		//if (monster.short == "goo-girl") temp = Math.round(temp * 1.5); - pomyśleć czy bdą dostawać bonusowe obrażenia
		//if (monster.short == "tentacle beast") temp = Math.round(temp * 1.2); - tak samo przemyśleć czy bedą dodatkowo ranione
		outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + temp + "</font></b> damage.");
		//Using fire attacks on the goo]
		//if(monster.short == "goo-girl") {
		//outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
		//if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		//}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(temp);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		monster.HP -= temp;
		if (player.hasStatusEffect(StatusEffects.HeroBane)) {
			if (player.statusEffectv2(StatusEffects.HeroBane) > 0) player.addStatusValue(StatusEffects.HeroBane, 2, -(player.statusEffectv2(StatusEffects.HeroBane)));
			player.addStatusValue(StatusEffects.HeroBane, 2, temp);
		}
		combat.HeroBaneProc();
		statScreenRefresh();
		if(monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}

//(45) Darkness Shard
	public function spellDarknessShard():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40)) player.HP -= spellCostBlack(40);
		else useMana(40,6);
		if(handleShell()){return;}
		//if (monster is Doppleganger)
		//{
		//(monster as Doppleganger).handleSpellResistance("whitefire");
		//flags[kFLAGS.SPELLS_CAST]++;
		//if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		//spellPerkUnlock();
		//return;
		//}
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You narrow your eyes, focusing your own lust with deadly intent.  At the palm of your hand form a shard from pure darkness that shots toward " + monster.a + monster.short + " !\n");
		temp = 0;
		temp += inteligencescalingbonus();
		temp *= spellModBlack();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			temp *= 1.75;
		}
		//High damage to goes.
		temp = calcEclypseMod(temp);
		if (monster.hasPerk(PerkLib.DarknessNature)) temp *= 0.2;
		if (monster.hasPerk(PerkLib.LightningVulnerability)) temp *= 0.5;
		if (monster.hasPerk(PerkLib.DarknessVulnerability)) temp *= 2;
		if (monster.hasPerk(PerkLib.LightningNature)) temp *= 5;
//	if (player.hasPerk(PerkLib.ColdMastery)) temp *= 2;
//	if (player.hasPerk(PerkLib.ColdAffinity)) temp *= 2;
		temp = Math.round(temp);
		//if (monster.short == "goo-girl") temp = Math.round(temp * 1.5); - pomyśleć czy bdą dostawać bonusowe obrażenia
		//if (monster.short == "tentacle beast") temp = Math.round(temp * 1.2); - tak samo przemyśleć czy bedą dodatkowo ranione
		outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + temp + "</font></b> damage.");
		//Using fire attacks on the goo]
		//if(monster.short == "goo-girl") {
		//outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
		//if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		//}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(temp);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		monster.HP -= temp;
		if (player.hasStatusEffect(StatusEffects.HeroBane)) {
			if (player.statusEffectv2(StatusEffects.HeroBane) > 0) player.addStatusValue(StatusEffects.HeroBane, 2, -(player.statusEffectv2(StatusEffects.HeroBane)));
			player.addStatusValue(StatusEffects.HeroBane, 2, temp);
		}
		combat.HeroBaneProc();
		statScreenRefresh();
		if(monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}

//(100) Ice Rain - AoE Ice spell
	public function spellIceRain():void {
		if (rand(2) == 0) flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		else flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200)) player.HP -= spellCost(200);
		else useMana(200,1);
		if(handleShell()){return;}
		//if (monster is Doppleganger)
		//{
		//(monster as Doppleganger).handleSpellResistance("whitefire");
		//flags[kFLAGS.SPELLS_CAST]++;
		//if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		//spellPerkUnlock();
		//return;
		//}
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You narrow your eyes, focusing your own lust and willpower with a deadly intent.  Above you starting to form small darn cloud that soon becoming quite wide and long.  Then almost endless rain of ice shards start to downpour on " + monster.a + monster.short + " and the rest of your surrounding!\n");
		temp = 0;
		temp += inteligencescalingbonus();
		temp *= spellMod();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			temp *= 1.75;
		}
		//High damage to goes.
		temp = calcGlacialMod(temp);
		if (monster.hasPerk(PerkLib.IceNature)) temp *= 0.2;
		if (monster.hasPerk(PerkLib.FireVulnerability)) temp *= 0.5;
		if (monster.hasPerk(PerkLib.IceVulnerability)) temp *= 2;
		if (monster.hasPerk(PerkLib.FireNature)) temp *= 5;
		if (player.hasPerk(PerkLib.ColdMastery)) temp *= 2;
		if (player.hasPerk(PerkLib.ColdAffinity)) temp *= 2;
		temp = Math.round(temp);
		//if (monster.short == "goo-girl") temp = Math.round(temp * 1.5); - pomyśleć czy bdą dostawać bonusowe obrażenia
		//if (monster.short == "tentacle beast") temp = Math.round(temp * 1.2); - tak samo przemyśleć czy bdą dodatkowo ranione
		if (monster.plural == true) temp *= 5;
		outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">(" + temp + ")");
		if (!monster.hasPerk(PerkLib.EnemyGroupType) && player.hasPerk(PerkLib.Convergence)) outputText(" (" + temp + ") ");
		outputText("</font></b> damage.");
		//Using fire attacks on the goo]
		//if(monster.short == "goo-girl") {
		//outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
		//if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		//}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		if (!monster.hasPerk(PerkLib.EnemyGroupType) && player.hasPerk(PerkLib.Convergence)) temp *= 2;
		checkAchievementDamage(temp);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		monster.HP -= temp;
		if (player.hasStatusEffect(StatusEffects.HeroBane)) {
			if (player.statusEffectv2(StatusEffects.HeroBane) > 0) player.addStatusValue(StatusEffects.HeroBane, 2, -(player.statusEffectv2(StatusEffects.HeroBane)));
			player.addStatusValue(StatusEffects.HeroBane, 2, temp);
		}
		combat.HeroBaneProc();
		statScreenRefresh();
		if(monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}

//(100) Fire Storm - AoE Fire spell
	public function spellFireStorm():void {
		if (rand(2) == 0) flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		else flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200)) player.HP -= spellCost(200);
		else useMana(200,1);
		if(handleShell()){return;}
		//if (monster is Doppleganger)
		//{
		//(monster as Doppleganger).handleSpellResistance("whitefire");
		//flags[kFLAGS.SPELLS_CAST]++;
		//if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		//spellPerkUnlock();
		//return;
		//}
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You narrow your eyes, focusing your own lust and willpower with a deadly intent.  Around you starting to form small vortex of flames that soon becoming quite wide.  Then with a single thought you sends all that fire like a unstoppable storm toward " + monster.a + monster.short + " and the rest of your surrounding!\n");
		temp = 0;
		temp += inteligencescalingbonus();
		temp *= spellMod();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			temp *= 1.75;
		}
		//High damage to goes.
		temp = calcInfernoMod(temp);
		if (monster.short == "goo-girl") temp = Math.round(temp * 1.5);
		if (monster.short == "tentacle beast") temp = Math.round(temp * 1.2);
		if (monster.plural == true) temp *= 5;
		if (monster.hasPerk(PerkLib.IceNature)) temp *= 5;
		if (monster.hasPerk(PerkLib.FireVulnerability)) temp *= 2;
		if (monster.hasPerk(PerkLib.IceVulnerability)) temp *= 0.5;
		if (monster.hasPerk(PerkLib.FireNature)) temp *= 0.2;
		if (player.hasPerk(PerkLib.FireAffinity)) temp *= 2;
		temp = Math.round(temp);
		outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">(" + temp + ")");
		if (!monster.hasPerk(PerkLib.EnemyGroupType) && player.hasPerk(PerkLib.Convergence)) outputText(" (" + temp + ") ");
		outputText("</font></b> damage.");
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your fire storm lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		if (!monster.hasPerk(PerkLib.EnemyGroupType) && player.hasPerk(PerkLib.Convergence)) temp *= 2;
		checkAchievementDamage(temp);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		monster.HP -= temp;
		if (player.hasStatusEffect(StatusEffects.HeroBane)) {
			if (player.statusEffectv2(StatusEffects.HeroBane) > 0) player.addStatusValue(StatusEffects.HeroBane, 2, -(player.statusEffectv2(StatusEffects.HeroBane)));
			player.addStatusValue(StatusEffects.HeroBane, 2, temp);
		}
		combat.HeroBaneProc();
		statScreenRefresh();
		if(monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}
	
	public function ManaShield():void {
		clearOutput();
		outputText("Deciding you need additional protection during current fight you spend moment to concentrate and form barrier made of mana around you.  It will block attacks as long you would have enough mana.\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		player.createStatusEffect(StatusEffects.ManaShield,0,0,0,0);
		enemyAI();
	}

	public function DeactivateManaShield():void {
		clearOutput();
		outputText("Deciding you not need for now to keep youe mana shield you concentrate and deactivating it.\n\n");
		player.removeStatusEffect(StatusEffects.ManaShield);
		enemyAI();
	}

	/**
	 * Generates from (x1,x2,x3,y1,y2) log-scale parameters (a,b,c) that will return:
	 * y1= 10 at x1=  10
	 * y2= 55 at x2= 100
	 * y3=100 at x3=1000
	 */
	private static const ChargeWeaponABC:Object = FnHelpers.FN.buildLogScaleABC(10,100,1000,10,100);
//(15) Charge Weapon – boosts your weapon attack value by 5 + (player.inte/10) * SpellMod till the end of combat.
	public function spellChargeWeapon(silent:Boolean = false):void {
		var ChargeWeaponBoost:Number = 10;
		if (player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) ChargeWeaponBoost += 5;
		if (player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) ChargeWeaponBoost += 5;
		if (player.hasPerk(PerkLib.Mage) && player.inte >= 50) ChargeWeaponBoost += 10;
		if (player.hasPerk(PerkLib.FocusedMind) && player.inte >= 50) ChargeWeaponBoost += 10;
		if (player.hasPerk(PerkLib.Channeling) && player.inte >= 60) ChargeWeaponBoost += 10;
		if (player.hasPerk(PerkLib.Archmage) && player.inte >= 75) ChargeWeaponBoost += 15;
		if (player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 100) ChargeWeaponBoost += 20;
		if (player.hasPerk(PerkLib.GreyMage) && player.inte >= 125) ChargeWeaponBoost += 25;
		if (player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 150) ChargeWeaponBoost += 30;
		if (player.hasPerk(PerkLib.JobEnchanter) && player.inte >= 50) ChargeWeaponBoost += 5;
		if (player.hasPerk(PerkLib.Spellsword) && player.inte >= 50) ChargeWeaponBoost += 15;
		if (player.hasPerk(PerkLib.JobBarbarian)) ChargeWeaponBoost -= 10;
		if (player.hasPerk(PerkLib.JobBrawler)) ChargeWeaponBoost -= 10;
		if (player.hasPerk(PerkLib.JobDervish)) ChargeWeaponBoost -= 10;
		if (player.hasPerk(PerkLib.IronFistsI)) ChargeWeaponBoost -= 10;
		if (player.hasPerk(PerkLib.JobMonk)) ChargeWeaponBoost -= 15;
		if (player.hasPerk(PerkLib.Berzerker)) ChargeWeaponBoost -= 15;
		if (player.hasPerk(PerkLib.Lustzerker)) ChargeWeaponBoost -= 15;
		if (player.hasPerk(PerkLib.WeaponMastery)) ChargeWeaponBoost -= 15;
		if (player.hasPerk(PerkLib.WeaponGrandMastery)) ChargeWeaponBoost -= 25;
		if (player.hasPerk(PerkLib.HeavyArmorProficiency)) ChargeWeaponBoost -= 15;
		if (player.hasPerk(PerkLib.AyoArmorProficiency)) ChargeWeaponBoost -= 15;
		if (player.hasPerk(PerkLib.Agility)) ChargeWeaponBoost -= 10;
		if (player.hasPerk(PerkLib.LightningStrikes)) ChargeWeaponBoost -= 10;
		if (player.hasPerk(PerkLib.BodyCultivator)) ChargeWeaponBoost -= 5;
	//	ChargeWeaponBoost += player.inte / 10;player.inte * 0.1 - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells
		if (ChargeWeaponBoost < 10) ChargeWeaponBoost = 10;
		ChargeWeaponBoost *= 1.5;
		if (player.hasPerk(PerkLib.JobEnchanter)) ChargeWeaponBoost *= 1.2;
		ChargeWeaponBoost *= spellModWhite();
		ChargeWeaponBoost = FnHelpers.FN.logScale(ChargeWeaponBoost,ChargeWeaponABC,10);
		ChargeWeaponBoost = Math.round(ChargeWeaponBoost);
		var ChargeWeaponDuration:Number = 5;
		if (player.hasPerk(PerkLib.LongerLastingBuffsI)) ChargeWeaponDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsII)) ChargeWeaponDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsIII)) ChargeWeaponDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsIV)) ChargeWeaponDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsV)) ChargeWeaponDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsVI)) ChargeWeaponDuration += 1;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) ChargeWeaponDuration += 5;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) ChargeWeaponDuration += 5;
		if (silent) {
			player.createStatusEffect(StatusEffects.ChargeWeapon,ChargeWeaponBoost,ChargeWeaponDuration,0,0);
			statScreenRefresh();
			return;
		}

		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < (30 * spellChargeWeaponCostMultiplier())) player.HP -= (30 * spellChargeWeaponCostMultiplier());
		else useMana((30 * spellChargeWeaponCostMultiplier()), 5);
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You utter words of power, summoning an electrical charge around your [weapon].  It crackles loudly, ensuring you'll do more damage with it for the rest of the fight.\n\n");
		player.createStatusEffect(StatusEffects.ChargeWeapon, ChargeWeaponBoost, ChargeWeaponDuration, 0, 0);
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		enemyAI();
	}

	/**
	 * Generates from (x1,x2,x3,y1,y2) log-scale parameters (a,b,c) that will return:
	 * y1= 10 at x1=  10
	 * y2= 55 at x2= 100
	 * y3=100 at x3=1000
	 */
	private static const ChargeArmorABC:Object = FnHelpers.FN.buildLogScaleABC(10,100,1000,10,100);
//(35) Charge Armor – boosts your armor value by 5 + (player.inte/10) * SpellMod till the end of combat.
	public function spellChargeArmor(silent:Boolean = false):void {
		var ChargeArmorBoost:Number = 10;
		if (player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) ChargeArmorBoost += 5;
		if (player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) ChargeArmorBoost += 5;
		if (player.hasPerk(PerkLib.Mage) && player.inte >= 50) ChargeArmorBoost += 10;
		if (player.hasPerk(PerkLib.FocusedMind) && player.inte >= 50) ChargeArmorBoost += 10;
		if (player.hasPerk(PerkLib.Channeling) && player.inte >= 60) ChargeArmorBoost += 10;
		if (player.hasPerk(PerkLib.Archmage) && player.inte >= 75) ChargeArmorBoost += 15;
		if (player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 100) ChargeArmorBoost += 20;
		if (player.hasPerk(PerkLib.GreyMage) && player.inte >= 125) ChargeArmorBoost += 25;
		if (player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 150) ChargeArmorBoost += 30;
		if (player.hasPerk(PerkLib.JobEnchanter) && player.inte >= 50) ChargeArmorBoost += 5;
		if (player.hasPerk(PerkLib.Spellarmor) && player.inte >= 50) ChargeArmorBoost += 15;
		if (player.hasPerk(PerkLib.JobBarbarian)) ChargeArmorBoost -= 10;
		if (player.hasPerk(PerkLib.JobBrawler)) ChargeArmorBoost -= 10;
		if (player.hasPerk(PerkLib.JobDervish)) ChargeArmorBoost -= 10;
		if (player.hasPerk(PerkLib.IronFistsI)) ChargeArmorBoost -= 10;
		if (player.hasPerk(PerkLib.JobMonk)) ChargeArmorBoost -= 15;
		if (player.hasPerk(PerkLib.Berzerker)) ChargeArmorBoost -= 15;
		if (player.hasPerk(PerkLib.Lustzerker)) ChargeArmorBoost -= 15;
		if (player.hasPerk(PerkLib.WeaponMastery)) ChargeArmorBoost -= 15;
		if (player.hasPerk(PerkLib.WeaponGrandMastery)) ChargeArmorBoost -= 25;
		if (player.hasPerk(PerkLib.HeavyArmorProficiency)) ChargeArmorBoost -= 15;
		if (player.hasPerk(PerkLib.AyoArmorProficiency)) ChargeArmorBoost -= 15;
		if (player.hasPerk(PerkLib.Agility)) ChargeArmorBoost -= 10;
		if (player.hasPerk(PerkLib.LightningStrikes)) ChargeArmorBoost -= 10;
		if (player.hasPerk(PerkLib.BodyCultivator)) ChargeArmorBoost -= 5;
	//	ChargeArmorBoost += player.inte / 10;player.inte * 0.1 - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells
		if (ChargeArmorBoost < 10) ChargeArmorBoost = 10;
		if (player.hasPerk(PerkLib.JobEnchanter)) ChargeArmorBoost *= 1.2;
		ChargeArmorBoost *= spellModWhite();
		ChargeArmorBoost = FnHelpers.FN.logScale(ChargeArmorBoost,ChargeArmorABC,10);
		ChargeArmorBoost = Math.round(ChargeArmorBoost);
		var ChargeArmorDuration:Number = 5;
		if (player.hasPerk(PerkLib.LongerLastingBuffsI)) ChargeArmorDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsII)) ChargeArmorDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsIII)) ChargeArmorDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsIV)) ChargeArmorDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsV)) ChargeArmorDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsVI)) ChargeArmorDuration += 1;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) ChargeArmorDuration += 5;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) ChargeArmorDuration += 5;
		if (silent) {
			player.createStatusEffect(StatusEffects.ChargeArmor,ChargeArmorBoost,ChargeArmorDuration,0,0);
			statScreenRefresh();
			return;
		}

		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < (40 * spellChargeArmorCostMultiplier())) player.HP -= (40 * spellChargeArmorCostMultiplier());
		else useMana((40 * spellChargeArmorCostMultiplier()), 5);
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You utter words of power, summoning an electrical charge around your");
		if (player.isNaked() && player.haveNaturalArmor() && player.hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor)) outputText(" natural armor.");
		else outputText(" [armor].");
		outputText("  It crackles loudly, ensuring you'll have more protection for the rest of the fight.\n\n");
		player.createStatusEffect(StatusEffects.ChargeArmor, ChargeArmorBoost, ChargeArmorDuration, 0, 0);
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		enemyAI();
	}
//(20) Blind – reduces your opponent's accuracy, giving an additional 50% miss chance to physical attacks.
	public function spellBlind():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(30)) player.HP -= spellCostWhite(30);
		else useMana(30,5);
		var successrate:int = 60;
		successrate -= (player.inte * 0.4);
		if (successrate > 20) successrate = 20;
		if (rand(100) > successrate) {
			if (monster.hasStatusEffect(StatusEffects.Shell)) {
				outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
				flags[kFLAGS.SPELLS_CAST]++;
				if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
				spellPerkUnlock();
				enemyAI();
				return;
			}
			if (monster is JeanClaude)
			{
				outputText("Jean-Claude howls, reeling backwards before turning back to you, rage clenching his dragon-like face and enflaming his eyes. Your spell seemed to cause him physical pain, but did nothing to blind his lidless sight.");

				outputText("\n\n“<i>You think your hedge magic will work on me, intrus?</i>” he snarls. “<i>Here- let me show you how it’s really done.</i>” The light of anger in his eyes intensifies, burning a retina-frying white as it demands you stare into it...");

				if (rand(player.spe) >= 50 || rand(player.inte) >= 50)
				{
					outputText("\n\nThe light sears into your eyes, but with the discipline of conscious effort you escape the hypnotic pull before it can mesmerize you, before Jean-Claude can blind you.");

					outputText("\n\n“<i>You fight dirty,</i>” the monster snaps. He sounds genuinely outraged. “<i>I was told the interloper was a dangerous warrior, not a little [boy] who accepts duels of honour and then throws sand into his opponent’s eyes. Look into my eyes, little [boy]. Fair is fair.</i>”");

					monster.HP -= int(10+(player.inte/3 + rand(player.inte/2)) * spellModWhite());
				}
				else
				{
					outputText("\n\nThe light sears into your eyes and mind as you stare into it. It’s so powerful, so infinite, so exquisitely painful that you wonder why you’d ever want to look at anything else, at anything at- with a mighty effort, you tear yourself away from it, gasping. All you can see is the afterimages, blaring white and yellow across your vision. You swipe around you blindly as you hear Jean-Claude bark with laughter, trying to keep the monster at arm’s length.");

					outputText("\n\n“<i>The taste of your own medicine, it is not so nice, eh? I will show you much nicer things in there in time intrus, don’t worry. Once you have learnt your place.</i>”");

					player.createStatusEffect(StatusEffects.Blind, 2 + player.inte / 20, 0, 0, 0);
				}
				if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
					(monster as FrostGiant).giantBoulderHit(2);
					enemyAI();
					return;
				}
				flags[kFLAGS.SPELLS_CAST]++;
				if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
				spellPerkUnlock();
				if(monster.HP < 1) doNext(endHpVictory);
				else enemyAI();
				return;
			}
			else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
			{
				outputText("You hold your [weapon] aloft and thrust your will forward, causing it to erupt in a blinding flash of light. The demons of the court scream and recoil from the radiant burst, clutching at their eyes and trampling over each other to get back.");

				outputText("\n\n<i>“Damn you, fight!”</i> Lethice screams, grabbing her whip and lashing out at the back-most demons, driving them forward -- and causing the middle bunch to be crushed between competing forces of retreating demons! <i>“Fight, or you'll be in the submission tanks for the rest of your miserable lives!”</i>");

				monster.createStatusEffect(StatusEffects.Blind, 5 * spellModWhite(), 0, 0, 0);
				outputText("\n\n");
				flags[kFLAGS.SPELLS_CAST]++;
				if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
				spellPerkUnlock();
				statScreenRefresh();
				enemyAI();
				return;
			}
			clearOutput();
			outputText("You glare at " + monster.a + monster.short + " and point at " + monster.pronoun2 + ".  A bright flash erupts before " + monster.pronoun2 + "!\n");
			if (monster is LivingStatue)
			{
				// noop
			}
			else if(rand(3) != 0) {
				outputText(" <b>" + monster.capitalA + monster.short + " ");
				if(monster.plural && monster.short != "imp horde") outputText("are blinded!</b>");
				else outputText("is blinded!</b>");
				monster.createStatusEffect(StatusEffects.Blind, 2 + player.inte / 20,0,0,0);
                if(monster is Diva){(monster as Diva).handlePlayerSpell("blind");}
				if(monster.short == "Isabella")
					if (kGAMECLASS.isabellaFollowerScene.isabellaAccent()) outputText("\n\n\"<i>Nein! I cannot see!</i>\" cries Isabella.");
					else outputText("\n\n\"<i>No! I cannot see!</i>\" cries Isabella.");
				if(monster.short == "Kiha") outputText("\n\n\"<i>You think blindness will slow me down?  Attacks like that are only effective on those who don't know how to see with their other senses!</i>\" Kiha cries defiantly.");
				if(monster.short == "plain girl") {
					outputText("  Remarkably, it seems as if your spell has had no effect on her, and you nearly get clipped by a roundhouse as you stand, confused. The girl flashes a radiant smile at you, and the battle continues.");
					monster.removeStatusEffect(StatusEffects.Blind);
				}
			}
		}
		else outputText(monster.capitalA + monster.short + " blinked!");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		statScreenRefresh();
		enemyAI();
	}
	//(30) Whitefire – burns the enemy for 10 + int/3 + rand(int/2) * spellMod.
	public function spellWhitefire():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40)) player.HP -= spellCostWhite(40);
		else useMana(40,5);
		if(handleShell()){return;}
		if (monster is Doppleganger)
		{
			(monster as Doppleganger).handleSpellResistance("whitefire");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			return;
		}
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			enemyAI();
			return;
		}
		else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
		{
			//Attack gains burn DoT for 2-3 turns.
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!");
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
			temp = 0;
			temp += inteligencescalingbonus();
			temp *= spellModWhite();
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 5;
			if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
				if (player.inte <= 100) critChance += (player.inte - 50) / 50;
				if (player.inte > 100) critChance += 10;
			}
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				temp *= 1.75;
			}
			temp *= 1.75;
			outputText(" (" + temp + ")");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		}
		else
		{
			clearOutput();
			outputText("You narrow your eyes, focusing your mind with deadly intent.  You snap your fingers and " + monster.a + monster.short + " is enveloped in a flash of white flames!\n");
			if(monster is Diva){(monster as Diva).handlePlayerSpell("whitefire");}
			temp = 0;
			temp += inteligencescalingbonus();
			temp *= spellModWhite();
			//Determine if critical hit!
			var crit2:Boolean = false;
			var critChance2:int = 5;
			if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
				if (player.inte <= 100) critChance2 += (player.inte - 50) / 50;
				if (player.inte > 100) critChance2 += 10;
			}
			if (rand(100) < critChance2) {
				crit = true;
				temp *= 1.75;
			}
			//High damage to goes.
			temp = calcInfernoMod(temp);
			if (monster.short == "goo-girl") temp = Math.round(temp * 1.5);
			if (monster.short == "tentacle beast") temp = Math.round(temp * 1.2);
			if (monster.hasPerk(PerkLib.IceNature)) temp *= 5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) temp *= 2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) temp *= 0.5;
			if (monster.hasPerk(PerkLib.FireNature)) temp *= 0.2;
			if (player.hasPerk(PerkLib.FireAffinity)) temp *= 2;
			temp = Math.round(temp);
			outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + temp + "</font></b> damage.");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			//Using fire attacks on the goo]
			if(monster.short == "goo-girl") {
				outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
				if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
			}
		}
		if(monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(temp);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		monster.HP -= temp;
		if (player.hasStatusEffect(StatusEffects.HeroBane)) {
			if (player.statusEffectv2(StatusEffects.HeroBane) > 0) player.addStatusValue(StatusEffects.HeroBane, 2, -(player.statusEffectv2(StatusEffects.HeroBane)));
			player.addStatusValue(StatusEffects.HeroBane, 2, temp);
		}
		combat.HeroBaneProc();
		statScreenRefresh();
		if (monster.HP < 1)
		{
			doNext(endHpVictory);
		}
		else
		{
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
			enemyAI();
		}
	}

//(45) Lightning Bolt - base lighting spell
	public function spellLightningBolt():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40)) player.HP -= spellCostWhite(40);
		else useMana(40,5);
		if(handleShell()){return;}
		//if (monster is Doppleganger)
		//{
		//(monster as Doppleganger).handleSpellResistance("whitefire");
		//flags[kFLAGS.SPELLS_CAST]++;
		//if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		//spellPerkUnlock();
		//return;
		//}
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You charge out energy in your hand and fire it out in the form of a powerful bolt of lightning at " + monster.a + monster.short + " !\n");
		temp = 0;
		temp += inteligencescalingbonus();
		temp *= spellModWhite();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			temp *= 1.75;
		}
		//High damage to goes.
		temp = calcVoltageMod(temp);
		if (monster.hasPerk(PerkLib.DarknessNature)) temp *= 5;
		if (monster.hasPerk(PerkLib.LightningVulnerability)) temp *= 2;
		if (monster.hasPerk(PerkLib.DarknessVulnerability)) temp *= 0.5;
		if (monster.hasPerk(PerkLib.LightningNature)) temp *= 0.2;
		if (player.hasPerk(PerkLib.LightningAffinity)) temp *= 2;
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) temp *= (1 + player.lust100);
		temp = Math.round(temp);
		//if (monster.short == "goo-girl") temp = Math.round(temp * 1.5); - pomyśleć czy bdą dostawać bonusowe obrażenia
		//if (monster.short == "tentacle beast") temp = Math.round(temp * 1.2); - tak samo przemyśleć czy bedą dodatkowo ranione
		outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + temp + "</font></b> damage.");
		//Using fire attacks on the goo]
		//if(monster.short == "goo-girl") {
		//outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
		//if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		//}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(temp);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		monster.HP -= temp;
		if (player.hasStatusEffect(StatusEffects.HeroBane)) {
			if (player.statusEffectv2(StatusEffects.HeroBane) > 0) player.addStatusValue(StatusEffects.HeroBane, 2, -(player.statusEffectv2(StatusEffects.HeroBane)));
			player.addStatusValue(StatusEffects.HeroBane, 2, temp);
		}
		combat.HeroBaneProc();
		statScreenRefresh();
		if(monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}

//(35) Blizzard
	public function spellBlizzard():void {
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(50)) player.HP -= spellCostWhite(50);
		else useMana(50,5);
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You utter words of power, summoning an ice storm.  It swirls arounds you, ensuring that you'll have more protection from the fire attacks for a few moments.\n\n");
		if (player.hasPerk(PerkLib.ColdMastery) || player.hasPerk(PerkLib.ColdAffinity)) {
			player.createStatusEffect(StatusEffects.Blizzard, 2 + player.inte / 10,0,0,0);
		}
		else {
			player.createStatusEffect(StatusEffects.Blizzard, 1 + player.inte / 25,0,0,0);
		}
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		enemyAI();
	}

	public function spellCleansingPalm():void
	{
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(30, USEFATG_MAGIC);
		if(handleShell()){return;}

		if (monster.short == "Jojo")
		{
			// Not a completely corrupted monkmouse
			if (kGAMECLASS.monk < 2)
			{
				outputText("You thrust your palm forward, sending a blast of pure energy towards Jojo. At the last second he sends a blast of his own against yours canceling it out\n\n");
				flags[kFLAGS.SPELLS_CAST]++;
				if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
				spellPerkUnlock();
				enemyAI();
				return;
			}
		}

		if (monster is LivingStatue)
		{
			outputText("You thrust your palm forward, causing a blast of pure energy to slam against the giant stone statue- to no effect!");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			enemyAI();
			return;
		}

		var corruptionMulti:Number = (monster.cor - 20) / 25;
		if (corruptionMulti > 1.5) {
			corruptionMulti = 1.5;
			corruptionMulti += ((monster.cor - 57.5) / 100); //The increase to multiplier is diminished.
		}

		//temp = int((player.inte / 4 + rand(player.inte / 3)) * (spellMod() * corruptionMulti));
		temp = int(10+(player.inte/3 + rand(player.inte/2)) * (spellMod() * corruptionMulti));

		if (temp > 0)
		{
			outputText("You thrust your palm forward, causing a blast of pure energy to slam against " + monster.a + monster.short + ", tossing");
			if ((monster as Monster).plural == true) outputText(" them");
			else outputText((monster as Monster).mfn(" him", " her", " it"));
			outputText(" back a few feet.\n\n");
			if (silly() && corruptionMulti >= 1.75) outputText("It's super effective!  ");
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 5;
			if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
				if (player.inte <= 100) critChance += (player.inte - 50) / 50;
				if (player.inte > 100) critChance += 10;
			}
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				temp *= 1.75;
			}
			outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + temp + "</font></b> damage.\n\n");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		}
		else
		{
			temp = 0;
			outputText("You thrust your palm forward, causing a blast of pure energy to slam against " + monster.a + monster.short + ", which they ignore. It is probably best you don’t use this technique against the pure.\n\n");
		}

		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		monster.HP -= temp;
		if (player.hasStatusEffect(StatusEffects.HeroBane)) {
			if (player.statusEffectv2(StatusEffects.HeroBane) > 0) player.addStatusValue(StatusEffects.HeroBane, 2, -(player.statusEffectv2(StatusEffects.HeroBane)));
			player.addStatusValue(StatusEffects.HeroBane, 2, temp);
		}
		combat.HeroBaneProc();
		statScreenRefresh();
		if(monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}
	private function handleShell():Boolean{
        if(monster.hasStatusEffect(StatusEffects.Shell)) {
            outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
            flags[kFLAGS.SPELLS_CAST]++;
            if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
            spellPerkUnlock();
            enemyAI();
            return true;
        }
		return false;
	}


}
}
