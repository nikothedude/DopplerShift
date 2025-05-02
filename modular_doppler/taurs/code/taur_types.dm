/*/**
 * Gets the taur mode of the mob. See /datum/sprite_accessory/taur's taur_mode var for more information.
 *
 * Returns STYLE_TAUR_* or NONE.
 */
/mob/living/carbon/human/proc/get_taur_mode()
	// NIKO NOTE ---- DO NOT MERGE IF THIS IS PRESENT --- Do we really need this? This feels messy...
	var/taur_mutant_bodypart = dna.species.mutant_bodyparts["taur"]
	if(!taur_mutant_bodypart)
		return NONE

	var/bodypart_name = taur_mutant_bodypart[MUTANT_INDEX_NAME]
	var/datum/sprite_accessory/taur/taur = SSaccessories.sprite_accessories["taur"][bodypart_name]
	if(!taur)
		return NONE

	return taur.taur_mode*/

/datum/sprite_accessory/taur
	icon = 'modular_doppler/taurs/icons/taur.dmi'
	//color_src = USE_MATRIXED_COLORS
	dimension_x = 64
	center = TRUE
	//relevent_layers = list(BODY_FRONT_LAYER, BODY_ADJ_LAYER, BODY_FRONT_UNDER_CLOTHES, ABOVE_BODY_FRONT_HEAD_LAYER)
	//genetic = TRUE
	/// The taur organ we will insert.
	var/obj/item/organ/organ_type = /obj/item/organ/taur_body/quadruped // quadruped by default, dont forget to override if you make another bodytype
	/*//flags_for_organ = SPRITE_ACCESSORY_HIDE_SHOES
	/// See ~doppler_defines.inventory.dm for further information
	/// Must be a single specific tauric suit variation bitflag. Don't do FLAG_1|FLAG_2
	var/taur_mode = NONE*/

/datum/sprite_accessory/taur/none
	name = SPRITE_ACCESSORY_NONE
	dimension_x = 32
	center = FALSE
	icon = 'modular_doppler/modular_customization/accessories/code/~overrides/icons/fallbacks.dmi'
	icon_state = "none"
	//factual = FALSE
	//flags_for_organ = NONE

/datum/sprite_accessory/taur/deer
	name = "Deer"
	icon_state = "deer"
	organ_type = /obj/item/organ/taur_body/quadruped/deer

/datum/sprite_accessory/taur/tarantula
	name = "Tarantula"
	icon_state = "tarantula"
	organ_type = /obj/item/organ/taur_body/spider

/datum/sprite_accessory/taur/naga
	name = "Naga"
	icon_state = "naga"
	//taur_mode = STYLE_TAUR_SNAKE
	organ_type = /obj/item/organ/taur_body/serpentine

/datum/sprite_accessory/taur/naga/striped
	name = "Naga, Striped"
	icon_state = "nagastriped"
	//taur_mode = STYLE_TAUR_SNAKE

/datum/sprite_accessory/taur/naga/rattle
	name = "Naga, Rattle"
	icon_state = "nagarattle"
	//taur_mode = STYLE_TAUR_SNAKE

/datum/sprite_accessory/taur/tentacle
	name = "Tentacle"
	icon_state = "tentaclealt"
	//taur_mode = STYLE_TAUR_SNAKE

/datum/sprite_accessory/taur/canine
	name = "Canine"
	icon_state = "canine"
	//taur_mode = STYLE_TAUR_PAW

/datum/sprite_accessory/taur/feline
	name = "Feline"
	icon_state = "feline"
	//taur_mode = STYLE_TAUR_PAW

/datum/sprite_accessory/taur/biglegs
	name = "Big Legs"
	icon_state = "biglegs"
	//taur_mode = STYLE_TAUR_PAW
	organ_type = /obj/item/organ/taur_body/anthro

/datum/sprite_accessory/taur/biglegs/stanced
	name = "Big Legs, Stanced"
	icon_state = "biglegs_stanced"

/datum/sprite_accessory/taur/biglegs/bird
	name = "Big Legs, Bird"
	icon_state = "biglegs_bird"

/datum/sprite_accessory/taur/biglegs/stanced/bird
	name = "Big Legs, Stanced Bird"
	icon_state = "biglegs_bird_stanced"

/datum/sprite_accessory/taur/biglegs/peg
	name = "Big Legs, Pegs"
	icon_state = "biglegs_peg"

/datum/sprite_accessory/taur/biglegs/stanced/peg
	name = "Big Legs, Stanced Pegs"
	icon_state = "biglegs_peg_stanced"
