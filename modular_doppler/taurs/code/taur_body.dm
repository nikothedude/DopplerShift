/obj/item/organ/taur_body
	name = "taur body"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_TAUR
	external_bodyshapes = BODYSHAPE_TAUR | BODYSHAPE_HIDE_SHOES
	use_mob_sprite_as_obj_sprite = TRUE

	organ_flags = parent_type::organ_flags | ORGAN_EXTERNAL
	preference = "feature_taur"
	bodypart_overlay = /datum/bodypart_overlay/mutant/taur_body

	/// If not null, the left leg limb we add to our mob will have this name.
	var/left_leg_name = "front legs"
	/// If not null, the right leg limb we add to our mob will have this name.
	var/right_leg_name = "back legs"

	/// The mob's old right leg. Used if the person switches to this organ and then back, so they don't just, have no legs anymore. Can be null.
	var/obj/item/bodypart/leg/right/old_right_leg = null
	/// The mob's old left leg. Used if the person switches to this organ and then back, so they don't just, have no legs anymore. Can be null.
	var/obj/item/bodypart/leg/right/old_left_leg = null

	/// If true, our sprite accessory will not render. Lazy.
	var/hide_self

	/// If true, this taur body allows a saddle to be equipped and used.
	var/can_use_saddle = FALSE
	/// If true, can ride saddled taurs and be ridden by other taurs with this set to TRUE.
	var/can_ride_saddled_taurs = FALSE

	/// When being ridden via saddle, how much the rider is offset on the x axis when facing west or east.
	var/riding_offset_side_x = 12
	/// When being ridden via saddle, how much the rider is offset on the y axis when facing west or east.
	var/riding_offset_side_y = 2

	/// When being ridden via saddle, how much the rider is offset on the x axis when facing north or south.
	var/riding_offset_front_x = 0
	/// When being ridden via saddle, how much the rider is offset on the y axis when facing north or south.
	var/riding_offset_front_y = 5

	/// Lazylist of (TEXT_DIR -> y offset) to be applied to taur-specific clothing that isn't specifically made for this sprite.
	var/list/taur_specific_clothing_y_offsets

	/// When considering how much to offset our rider, we multiply size scaling against this.
	var/riding_offset_scaling_mult = 0.8

/obj/item/organ/taur_body/quadruped
	can_use_saddle = TRUE

/obj/item/organ/taur_body/quadruped/synth
	organ_flags = parent_type::organ_flags | ORGAN_ROBOTIC

/obj/item/organ/taur_body/quadruped/deer

/obj/item/organ/taur_body/quadruped/deer/Initialize(mapload)
	. = ..()

	taur_specific_clothing_y_offsets = list(
		TEXT_EAST = 3,
		TEXT_WEST = 3,
		TEXT_NORTH = 0,
		TEXT_SOUTH = 0,
	)

/obj/item/organ/taur_body/serpentine
	left_leg_name = "upper serpentine body"
	right_leg_name = "lower serpentine body"

/obj/item/organ/taur_body/serpentine/synth
	organ_flags = parent_type::organ_flags | ORGAN_ROBOTIC

/obj/item/organ/taur_body/spider
	left_leg_name = "left legs"
	right_leg_name = "right legs"

/obj/item/organ/taur_body/tentacle
	left_leg_name = "front tentacles"
	right_leg_name = "back tentacles"

/obj/item/organ/taur_body/anthro
	left_leg_name = null
	right_leg_name = null

	can_ride_saddled_taurs = TRUE

/obj/item/organ/taur_body/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	old_right_leg = receiver.get_bodypart(BODY_ZONE_R_LEG)
	old_left_leg = receiver.get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/leg/left/taur/new_left_leg
	var/obj/item/bodypart/leg/right/taur/new_right_leg

	if(organ_flags & ORGAN_ORGANIC)
		new_left_leg = new /obj/item/bodypart/leg/left/taur()
		new_right_leg = new /obj/item/bodypart/leg/right/taur()

	if(organ_flags & ORGAN_ROBOTIC)
		new_left_leg = new /obj/item/bodypart/leg/left/robot/android/taur()
		new_right_leg = new /obj/item/bodypart/leg/right/robot/android/taur()

	if (left_leg_name)
		new_left_leg.name = left_leg_name + " (Left leg)"
		new_left_leg.plaintext_zone = lowertext(new_left_leg.name) // weird otherwise
	if (right_leg_name)
		new_right_leg.name = right_leg_name + " (Right leg)"
		new_right_leg.plaintext_zone = lowertext(new_right_leg.name)

	new_left_leg.bodyshape |= external_bodyshapes
	if(old_left_leg)
		old_left_leg.drop_limb(special = TRUE, move_to_floor = FALSE)
		old_left_leg.moveToNullspace()
	new_left_leg.replace_limb(receiver, special = TRUE)
	new_left_leg.bodytype |= BODYTYPE_TAUR

	new_right_leg.bodyshape |= external_bodyshapes
	if(old_right_leg)
		old_right_leg.drop_limb(special = TRUE, move_to_floor = FALSE)
		old_right_leg.moveToNullspace()
	new_right_leg.replace_limb(receiver, special = TRUE)
	new_right_leg.bodytype |= BODYTYPE_TAUR

	return ..()


/obj/item/organ/taur_body/on_mob_remove(mob/living/carbon/organ_owner, special, moving)
	if(QDELETED(owner))
		return ..()

	var/obj/item/bodypart/leg/left/left_leg = organ_owner.get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/leg/right/right_leg = organ_owner.get_bodypart(BODY_ZONE_R_LEG)

	if(left_leg)
		left_leg.drop_limb(special = TRUE, move_to_floor = FALSE)
		qdel(left_leg)

	if(right_leg)
		right_leg.drop_limb(special = TRUE, move_to_floor = FALSE)
		qdel(right_leg)

	if(old_left_leg)
		old_left_leg.replace_limb(organ_owner, special = TRUE)
		old_left_leg = null

	if(old_right_leg)
		old_right_leg.replace_limb(organ_owner, special = TRUE)
		old_right_leg = null

	// We don't call `synchronize_bodytypes()` here, because it's already going to get called in the parent because `external_bodyshapes` has a value.

	return ..()

/obj/item/organ/taur_body/Destroy()
	. = ..()
	if(old_left_leg)
		QDEL_NULL(old_left_leg)

	if(old_right_leg)
		QDEL_NULL(old_right_leg)

/obj/item/organ/taur_body/proc/get_riding_offset(oversized = FALSE)
	var/size_scaling = owner.current_size / RESIZE_DEFAULT_SIZE
	var/scaling_mult = 1 + (size_scaling * riding_offset_scaling_mult)

	return list(
		TEXT_NORTH = list(riding_offset_front_x, round((riding_offset_front_y + taur_specific_clothing_y_offsets?[TEXT_NORTH]) * scaling_mult, 1)),
		TEXT_SOUTH = list(riding_offset_front_x, round((riding_offset_front_y + taur_specific_clothing_y_offsets?[TEXT_SOUTH]) * scaling_mult, 1)),
		TEXT_EAST = list(round(-riding_offset_side_x * scaling_mult, 1), round((riding_offset_side_y + taur_specific_clothing_y_offsets?[TEXT_EAST]) * scaling_mult, 1)),
		TEXT_WEST = list(round(riding_offset_side_x * scaling_mult, 1), round((riding_offset_side_y + taur_specific_clothing_y_offsets?[TEXT_WEST]) * scaling_mult, 1)),
	)
