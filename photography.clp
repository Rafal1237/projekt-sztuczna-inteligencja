(defmodule MAIN)

;; =========================
;; TEMPLATES
;; =========================

(deftemplate ask (slot id))
(deftemplate answer (slot id) (slot value))
(deftemplate result (slot text))

;; =========================
;; START
;; =========================

(deffacts start
  (ask (id feel_like_shooting)))

;; =========================================================
;; LEVEL 1 – MOTIVATION
;; =========================================================

(defrule feel-like-shooting-no
  (answer (id feel_like_shooting) (value no))
  (not (ask))
  =>
  (assert (ask (id photography_related))))

(defrule feel-like-shooting-yes
  (answer (id feel_like_shooting) (value yes))
  (not (ask))
  =>
  (assert (ask (id shoot_myself))))

;; =========================================================
;; NO SHOOTING PATH
;; =========================================================

(defrule photography-related-no
  (answer (id photography_related) (value no))
  (not (ask))
  =>
  (assert (result (text study_masters))))

(defrule photography-related-yes
  (answer (id photography_related) (value yes))
  (not (ask))
  =>
  (assert (ask (id mentally_active))))

(defrule mentally-active-yes
  (answer (id mentally_active) (value yes))
  (not (ask))
  =>
  (assert (result (text cross_pollinate_hobbies))))

(defrule mentally-active-no
  (answer (id mentally_active) (value no))
  (not (ask))
  =>
  (assert (result (text take_a_walk))))

;; =========================================================
;; SHOOTING PATH
;; =========================================================

(defrule shoot-myself-no
  (answer (id shoot_myself) (value no))
  (not (ask))
  =>
  (assert (ask (id someone_else))))

(defrule shoot-myself-yes
  (answer (id shoot_myself) (value yes))
  (not (ask))
  =>
  (assert (ask (id confidence_issue))))

;; =========================================================
;; SELF PORTRAIT / CONFIDENCE
;; =========================================================

(defrule someone-else-yes
  (answer (id someone_else) (value yes))
  (not (ask))
  =>
  (assert (result (text ask_friend_portrait))))

(defrule someone-else-no
  (answer (id someone_else) (value no))
  (not (ask))
  =>
  (assert (result (text shadow_or_mirror))))

(defrule confidence-issue-yes
  (answer (id confidence_issue) (value yes))
  (not (ask))
  =>
  (assert (ask (id want_confidence))))

(defrule confidence-issue-no
  (answer (id confidence_issue) (value no))
  (not (ask))
  =>
  (assert (ask (id choose_where_or_what))))

(defrule want-confidence-yes
  (answer (id want_confidence) (value yes))
  (not (ask))
  =>
  (assert (ask (id choose_where_or_what))))

(defrule want-confidence-no
  (answer (id want_confidence) (value no))
  (not (ask))
  =>
  (assert (ask (id choose_where_or_what))))

;; =========================================================
;; WHERE vs WHAT
;; =========================================================

(defrule choose-where
  (answer (id choose_where_or_what) (value where))
  (not (ask))
  =>
  (assert (ask (id leave_home))))

(defrule choose-what
  (answer (id choose_where_or_what) (value what))
  (not (ask))
  =>
  (assert (ask (id inspiration_from_self))))

;; =========================================================
;; WHERE TO SHOOT
;; =========================================================

(defrule leave-home-no
  (answer (id leave_home) (value no))
  (not (ask))
  =>
  (assert (ask (id photograph_objects))))

(defrule leave-home-yes
  (answer (id leave_home) (value yes))
  (not (ask))
  =>
  (assert (ask (id travel_close))))

(defrule photograph-objects-yes
  (answer (id photograph_objects) (value yes))
  (not (ask))
  =>
  (assert (result (text shoot_camera_bag))))

(defrule photograph-objects-no
  (answer (id photograph_objects) (value no))
  (not (ask))
  =>
  (assert (result (text loved_object_photoshoot))))

(defrule travel-close-yes
  (answer (id travel_close) (value yes))
  (not (ask))
  =>
  (assert (ask (id walking_distance))))

(defrule travel-close-no
  (answer (id travel_close) (value no))
  (not (ask))
  =>
  (assert (ask (id overseas))))

(defrule walking-distance-yes
  (answer (id walking_distance) (value yes))
  (not (ask))
  =>
  (assert (result (text five_blocks))))

(defrule walking-distance-no
  (answer (id walking_distance) (value no))
  (not (ask))
  =>
  (assert (result (text big_city))))

(defrule overseas-yes
  (answer (id overseas) (value yes))
  (not (ask))
  =>
  (assert (result (text international_adventure))))

(defrule overseas-no
  (answer (id overseas) (value no))
  (not (ask))
  =>
  (assert (result (text road_trip))))

;; =========================================================
;; WHAT TO SHOOT (INSPIRATION)
;; =========================================================

(defrule inspiration-self-yes
  (answer (id inspiration_from_self) (value yes))
  (not (ask))
  =>
  (assert (ask (id feeling_social))))

(defrule inspiration-self-no
  (answer (id inspiration_from_self) (value no))
  (not (ask))
  =>
  (assert (result (text study_masters))))

(defrule feeling-social-yes
  (answer (id feeling_social) (value yes))
  (not (ask))
  =>
  (assert (result (text share_work))))

(defrule feeling-social-no
  (answer (id feeling_social) (value no))
  (not (ask))
  =>
  (assert (ask (id challenge))))

(defrule challenge-yes
  (answer (id challenge) (value yes))
  (not (ask))
  =>
  (assert (result (text opposite_topic))))

(defrule challenge-no
  (answer (id challenge) (value no))
  (not (ask))
  =>
  (assert (ask (id topic_choice))))

(defrule topic-choice
  (answer (id topic_choice) (value juxtaposition))
  (not (ask))
  =>
  (assert (result (text shoot_juxtaposition))))
