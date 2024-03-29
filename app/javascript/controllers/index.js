// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import ChatroomSubscriptionController from "./chatroom_subscription_controller"
application.register("chatroom-subscription", ChatroomSubscriptionController)

import ComponentsController from "./components_controller"
application.register("components", ComponentsController)

import DropdownRadiusController from "./dropdown_radius_controller"
application.register("dropdown-radius", DropdownRadiusController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import MapController from "./map_controller"
application.register("map", MapController)

import SwiperController from "./swiper_controller"
application.register("swiper", SwiperController)

import ToggleElementController from "./toggle_element_controller"
application.register("toggle-element", ToggleElementController)

import TripMapController from "./trip_map_controller"
application.register("trip-map", TripMapController)
