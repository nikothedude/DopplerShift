/// An element that makes guns throw their user back if they are just a little guy
/datum/element/heavy_recoil
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2

	/// The throwing force applied to the gun's user
	var/throwing_force
	/// The throwing range applied to the gun's user
	var/throwing_range
	/// The knockdown time applied to the gun's user
	var/knockdown_time
	/// Is the throw gentle?
	var/gentle

/datum/element/heavy_recoil/Attach(datum/target, throwing_force = 2, throwing_range = 3, knockdown_time = 1 SECONDS, gentle = FALSE)
	. = ..()
	if(!isgun(target))
		return ELEMENT_INCOMPATIBLE

	src.throwing_force = throwing_force
	src.throwing_range = throwing_range
	src.knockdown_time = knockdown_time
	src.gentle = gentle

	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(examine))
	RegisterSignal(target, COMSIG_GUN_FIRED, PROC_REF(throw_it_back))

/datum/element/heavy_recoil/Detach(datum/target)
	. = ..()
	UnregisterSignal(target, COMSIG_ATOM_EXAMINE)
	UnregisterSignal(target, COMSIG_GUN_FIRED)

/// Warns that this gun might throw you away really hard
/datum/element/heavy_recoil/proc/examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_notice("It has some serious kick to it, smaller users should take caution while firing.")

/// Checks if the shooter is just a little guy. If so? Throw it back.
/datum/element/heavy_recoil/proc/throw_it_back(obj/item/gun/weapon, mob/living/carbon/user, atom/target, params, zone_override)
	SIGNAL_HANDLER

	if (!ishuman(user))
		return

	var/mob/living/carbon/human/human_user = user

	if(!isteshari(user) && !isdwarf(user) && !HAS_TRAIT(user, TRAIT_DWARF) && !human_user.mob_height > HUMAN_HEIGHT_SHORTEST)
		return

	var/fling_direction = REVERSE_DIR(user.dir)
	var/atom/throw_target = get_edge_target_turf(user, fling_direction)
	if (knockdown_time > 0)
		user.Knockdown(knockdown_time)
	user.throw_at(throw_target, throwing_range, throwing_force, gentle = gentle)

	user.visible_message(span_warning("[weapon] sends [user] flying back as it fires!"), \
		span_warning("[weapon] sends you flying back as it fires!"))

/obj/item/gun/ballistic/shotgun/Initialize(mapload)
	if (!(gun_flags & NOT_A_REAL_GUN))
		AddElement(/datum/element/heavy_recoil, throwing_force = 1, throwing_range = 1, knockdown_time = 0, gentle = TRUE)

	return ..()
