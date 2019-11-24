// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

var $ = require("jquery");

import 'jquery-datetimepicker/build/jquery.datetimepicker.full.min'
import 'jquery-datetimepicker/build/jquery.datetimepicker.min.css'

import 'select2/dist/js/select2.full.min'
import 'select2/dist/css/select2.min.css'

import '@fortawesome/fontawesome-free/js/all';
import './libs/custom_bootstrap';
import './libs/custom_datetimepicker'
import './libs/custom_multi_select'

// SCSS
import '../stylesheets/application';

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
