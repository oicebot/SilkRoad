alias silkroad_start {
  set %silkroad_window_name @silkroad
  set %silkroad_resource_dir $scriptdir
  set %silkroad_pub_goods_cards_area 391 161
  set %silkroad_pub_goods_cards_dimension 60 81
  set %silkroad_pub_goods_cards_content 0 0 0 0 0 0
  set %silkroad_pub_box_area 146 336
  set %silkroad_pub_box_dimension 27 30
  set %silkroad_pub_box_content 5 5 5 5 5 5
  set %silkroad_pub_equipment_cards_area 146 223
  set %silkroad_pub_equipment_cards_dimension 60 96
  set %silkroad_pub_equipment_cards_content 14 2 2 2

  show_table
  show_goods_cards
  show_box
  show_equipment

  ;unset %silkroad_*
}

alias test_goods_cards {
  set %silkroad_pub_goods_cards_content $1-
  show_goods_cards
}

alias test_box {
  set %silkroad_pub_box_content $1-

  show_box
}


alias -l show_table {
  if ($window(%silkroad_window_name) == $null) window -Dpfk0 +elt %silkroad_window_name -1 -1 700 560
  if ($window(%silkroad_window_name) == %silkroad_window_name) drawpic %silkroad_window_name 0 0 " $+ %silkroad_resource_dir $+ table.jpg $+ "
}

alias -l show_goods_cards {
  if ($window(%silkroad_window_name) == $null) show_table
  var %i = 0
  while (%i < 6) {
    var %x = $calc($gettok(%silkroad_pub_goods_cards_area, 1, 32) + $gettok(%silkroad_pub_goods_cards_dimension, 1, 32) * (%i % 3))
    var %y = $calc($gettok(%silkroad_pub_goods_cards_area, 2, 32) + $gettok(%silkroad_pub_goods_cards_dimension, 2, 32) * $int($calc(%i / 3)))
    var %img = " $+ %silkroad_resource_dir $+ goods_ $+ $gettok(%silkroad_pub_goods_cards_content, $calc(%i + 1), 32) $+ .jpg $+ "

    drawpic -c %silkroad_window_name %x %y %img
    inc %i
  }
}
alias -l show_box {
  if ($window(%silkroad_window_name) == $null) show_table
  var %img = " $+ %silkroad_resource_dir $+ box_back.jpg $+ "
  drawpic -c %silkroad_window_name %silkroad_pub_box_area %img
  var %i = 0
  while (%i < 6) {
    var %x = $calc($gettok(%silkroad_pub_box_area, 1, 32) + ($gettok(%silkroad_pub_box_dimension, 1, 32) * 5 + 5) * $int($calc(%i / 3)))
    var %y = $calc($gettok(%silkroad_pub_box_area, 2, 32) + $gettok(%silkroad_pub_box_dimension, 2, 32) * (%i % 3))
    var %img = " $+ %silkroad_resource_dir $+ box_ $+ $calc(%i + 1) $+ .jpg $+ "
    var %ii = 0
    while (%ii < $gettok(%silkroad_pub_box_content, $calc(%i + 1), 32)) {
      %x = $calc(%x + %silkroad_pub_box_dimension * %ii)
      drawpic -c %silkroad_window_name %x %y %img
      inc %ii
    }
    inc %i
  }
}
alias -l show_equipment {
  if ($window(%silkroad_window_name) == $null) show_table
  var %i = 0
  while (%i < 4) {
    var %x = $calc($gettok(%silkroad_pub_equipment_cards_area, 1, 32) + $gettok(%silkroad_pub_equipment_cards_dimension, 1, 32)  * %i)
    var %y = $gettok(%silkroad_pub_equipment_cards_area, 2, 32)
    var %img = " $+ %silkroad_resource_dir $+ equipment_ $+ $calc(%i + 1) $+ .jpg $+ "

    drawpic -c %silkroad_window_name %x %y %img
    drawtext -ob %silkroad_window_name 0 1 Arial 12 $calc(%x + 4) $calc(%y + 80) - $gettok(%silkroad_pub_equipment_cards_content, $calc(%i + 1), 32) -
    inc %i
  }


}
