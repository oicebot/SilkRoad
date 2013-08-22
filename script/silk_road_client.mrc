alias silkroad_start {
  set %silkroad_window_name @silkroad
  set %silkroad_resource_dir $scriptdir
  set %silkroad_pub_goods_area 406 104
  set %silkroad_pub_goods_dimension 60 84
  set %silkroad_pub_goods_rectangle -1 -1 -2 -2
  set %silkroad_pub_box_area 146 276
  set %silkroad_pub_box_dimension 27 30
  set %silkroad_pub_box_rectangle -1 -1 -5 -3
  set %silkroad_pub_equipment_area 146 173
  set %silkroad_pub_equipment_dimension 64 96
  set %silkroad_pub_equipment_rectangle -1 -1 -2 2
  set %silkroad_pub_equipment_price 10 12 8 11

  set %silkroad_pub_stack_g_area 426 276
  set %silkroad_pub_stack_area 468 300
  set %silkroad_pub_stack_dimension 80 56
  set %silkroad_pub_stack_rectangle 0 0 0 0

  set %silkroad_player0_equipment_area 26 376
  set %silkroad_player0_equipment_dimension 60 96
  set %silkroad_player0_goods_area 620 391
  set %silkroad_player0_goods_dimension 25 80
  set %silkroad_player0_money_area 580 510


  set %silkroad_pub_stack_count 66

  set %silkroad_pub_goods_content 0 0 0 0 0 0
  set %silkroad_pub_box_content 5 5 5 5 5 5
  set %silkroad_pub_equipment_content 6 2 2 2

  set %silkroad_player0_equipment_content 1 1
  set %silkroad_player1_equipment_content 1 1
  set %silkroad_player2_equipment_content 1 1
  set %silkroad_player3_equipment_content 1 1

  set %silkroad_player0_box_content 0 0
  set %silkroad_player1_box_content 0 0
  set %silkroad_player2_box_content 0 0
  set %silkroad_player3_box_content 0 0

  set %silkroad_player0_goods_content 1 2 3 4 5 6 1 2 3 4 5 6
  set %silkroad_player1_goods_count 3
  set %silkroad_player2_goods_count 3
  set %silkroad_player3_goods_count 3

  set %silkroad_player0_money 10
  show_table
  ;unset %silkroad_*
}

alias -l show_table {
  show_background
  show_goods
  show_box
  show_equipment
  show_player0
  show_hand
  show_money
  show_stack
}

alias update_pub_goods {
  set %silkroad_pub_goods_content $1-
  show_goods
}

alias update_pub_box {
  set %silkroad_pub_box_content $1-
  show_box
}

alias update_pub_equipment {
  set %silkroad_pub_equipment_content $1-
  show_equipment
}

alias update_money {
  set %silkroad_player0_money $1
  show_money
  show_equipment
}

alias update_stack {
  set %silkroad_pub_stack_count $1
  show_stack
}

alias -l img_path {
  return " $+ %silkroad_resource_dir $+ $1- $+ "
}


alias -l set_rectangle {
  var %x = $$1
  var %y = $$2
  var %w = $$3
  var %h = $$4
  var %dx = $gettok($$5, 1, 32)
  var %dy = $gettok($$5, 2, 32)
  var %dw = $gettok($$5, 3, 32)
  var %dh = $gettok($$5, 4, 32)

  return $calc(%x + %dx) $calc(%y + %dy) $calc(%w + %dw) $calc(%h + %dh) 

}

alias -l show_background {
  if ($window(%silkroad_window_name) == $null) window -Dpfk0 +elt %silkroad_window_name -1 -1 700 560
  if ($window(%silkroad_window_name) == %silkroad_window_name) drawpic %silkroad_window_name 0 0 $img_path(table.jpg)
}

alias -l show_goods {
  if ($window(%silkroad_window_name) == $null) show_table
  var %x, %y, %img
  var %sx = $gettok(%silkroad_pub_goods_area, 1, 32)
  var %sy = $gettok(%silkroad_pub_goods_area, 2, 32)
  inc %sx
  inc %sy
  var %w = $gettok(%silkroad_pub_goods_dimension, 1, 32)
  var %h = $gettok(%silkroad_pub_goods_dimension, 2, 32)
  var %i = 0
  while (%i < 6) {
    %x = $calc(%sx + %w * (%i % 3))
    %y = $calc(%sy + %h * $int($calc(%i / 3)))
    %img = $img_path(goods_ $+ $gettok(%silkroad_pub_goods_content, $calc(%i + 1), 32) $+ .jpg)
    drawrect %silkroad_window_name 1 1 $set_rectangle(%x, %y, %w, %h, %silkroad_pub_goods_rectangle)
    drawpic -c %silkroad_window_name %x %y %img
    inc %i
  }
}
alias -l show_box {
  if ($window(%silkroad_window_name) == $null) show_table
  var %img = $img_path(box_back.jpg)
  drawpic -c %silkroad_window_name %silkroad_pub_box_area %img
  var %sx = $gettok(%silkroad_pub_box_area, 1, 32)
  var %sy = $gettok(%silkroad_pub_box_area, 2, 32)
  inc %sx
  inc %sy
  var %w = $gettok(%silkroad_pub_box_dimension, 1, 32)
  var %gw = $calc(%w * 5 + 5)
  var %h = $gettok(%silkroad_pub_box_dimension, 2, 32)
  var %i = 0
  while (%i < 6) {
    var %x = $calc(%sx + %gw * $int($calc(%i / 3)))
    var %y = $calc(%sy + %h * (%i % 3))
    var %img = $img_path(box_ $+ $calc(%i + 1) $+ .jpg)
    var %ii = 0
    var %c = $gettok(%silkroad_pub_box_content, $calc(%i + 1), 32)
    drawrect %silkroad_window_name 1 1 $set_rectangle(%x, %y, %gw, %h, %silkroad_pub_box_rectangle)
    while (%ii < %c) {
      drawpic -c %silkroad_window_name %x %y %img
      %x = $calc(%x + %w)
      inc %ii
    }
    inc %i
  }
}
alias -l show_equipment {
  if ($window(%silkroad_window_name) == $null) show_table
  var %x, %y, %count, %img
  var %sx = $gettok(%silkroad_pub_equipment_area, 1, 32)
  var %sy = $gettok(%silkroad_pub_equipment_area, 2, 32)
  inc %sx
  inc %sy
  var %w = $gettok(%silkroad_pub_equipment_dimension, 1, 32)
  var %h = $gettok(%silkroad_pub_equipment_dimension, 2, 32)
  var %i = 0
  while (%i < 4) {
    %x = $calc(%sx + %w * %i)
    %y = %sy
    %count = $gettok(%silkroad_pub_equipment_content, $calc(%i + 1), 32)
    %img = $img_path($iif(%silkroad_player0_money >= $gettok(%silkroad_pub_equipment_price, $calc(%i +1), 32), equipment_, equipment_grey_) $+ $calc(%i + 1) $+ .jpg)
    drawrect %silkroad_window_name 1 1 $set_rectangle(%x, %y, %w, %h, %silkroad_pub_equipment_rectangle)
    drawpic -c %silkroad_window_name %x %y %img
    drawtext -ob %silkroad_window_name 0 1 Arial 12 $calc(%x + 4) $calc(%y + 80) - %count -
    inc %i
  }
}

alias -l show_stack {
  if ($window(%silkroad_window_name) == $null) show_table
  var %x, %y, %img
  %img = $img_path(stack_back.jpg)
  drawpic -c %silkroad_window_name %silkroad_pub_stack_g_area %img
  var %sx = $gettok(%silkroad_pub_stack_area, 1, 32)
  var %sy = $gettok(%silkroad_pub_stack_area, 2, 32)
  inc %sx
  inc %sy
  var %w = $gettok(%silkroad_pub_stack_dimension, 1, 32)
  var %h = $gettok(%silkroad_pub_stack_dimension, 2, 32)
  %img = $img_path(goods_l_0.jpg)
  var %i = 0
  var %c = $int($calc(%silkroad_pub_stack_count / 6 + 1))
  %x = %sx
  %y = %sy
  while (%i < %c) {
    drawpic -c %silkroad_window_name %x %y %img
    dec %x
    dec %y 0.5
    inc %i
  }
  drawrect %silkroad_window_name 0 1 $set_rectangle(%x, %y, %w, %h, %silkroad_pub_stack_rectangle)
  drawtext -ob %silkroad_window_name 0 1 Arial 12 $calc(%x + 5) $calc(%y + 30) - %silkroad_pub_stack_count -

}

alias -l show_player0 {
  if ($window(%silkroad_window_name) == $null) show_table
  %silkroad_player0_equipment_content = $sorttok(%silkroad_player0_equipment_content, 32, n)
  var %x, %y, %card_type, %box_type, %img
  var %sx = $gettok(%silkroad_player0_equipment_area, 1, 32)
  var %sy = $gettok(%silkroad_player0_equipment_area, 2, 32)
  var %w = $gettok(%silkroad_player0_equipment_dimension, 1, 32)
  var %i = 0
  var %c = $numtok(%silkroad_player0_equipment_content, 32)
  while (%i < %c) {
    %x = $calc(%sx + %w * %i)
    %y = %sy
    %card_type = $gettok(%silkroad_player0_equipment_content, $calc(%i + 1), 32)
    %img = $img_path(equipment_ $+ %card_type $+ .jpg)
    drawpic -c %silkroad_window_name %x %y %img
    if (%card_type == 1) {
      %x = $calc(%x + 14)
      %y = $calc(%y + 67)
      %box_type = $gettok(%silkroad_player0_box_content, $calc(%i + 1), 32)
      if (%box_type > 0) {
        %img = $img_path(box_ $+ %box_type $+ .jpg)
        drawpic -c %silkroad_window_name %x %y %img
      }
    }
    inc %i
  }

}

alias -l show_hand {
  if ($window(%silkroad_window_name) == $null) show_table
  %silkroad_player0_goods_content = $sorttok(%silkroad_player0_goods_content, 32, nr)
  var %x, %y, %card_type, %img
  var %sx = $gettok(%silkroad_player0_goods_area, 1, 32)
  var %sy = $gettok(%silkroad_player0_goods_area, 2, 32)
  var %w = $gettok(%silkroad_player0_goods_dimension, 1, 32)
  var %i = 0
  var %c = $numtok(%silkroad_player0_goods_content, 32)
  while (%i < %c) {
    %x = $calc(%sx - %w * %i)
    %y = %sy
    %card_type = $gettok(%silkroad_player0_goods_content, $calc(%i + 1), 32)
    %img = $img_path(goods_ $+ %card_type $+ .jpg)
    drawpic -c %silkroad_window_name %x %y %img
    inc %i
  }

}

alias -l show_money {
  if ($window(%silkroad_window_name) == $null) show_table

  var %x = $gettok(%silkroad_player0_money_area, 1, 32)
  var %y = $gettok(%silkroad_player0_money_area, 2, 32)
  var %img = $img_path(money_back.jpg)
  drawpic -c %silkroad_window_name %x %y %img
  %img = $img_path(money.bmp)
  drawpic -t %silkroad_window_name 0 %x %y %img
  drawtext -o %silkroad_window_name 0 Arial 32 $calc(%x + 45) $calc(%y + 3) %silkroad_player0_money

}
