// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application"

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)

import  ImageSelectorController from "./image_selector_controller"
application.register("image-selector", ImageSelectorController)

import Clipboard from '@stimulus-components/clipboard'
application.register('clipboard', Clipboard)
