/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Typed from 'typed.js';

document.addEventListener("DOMContentLoaded", function(event) {
  
	var toggle = document.getElementById("toggle-menu");
	if(toggle) {
	  toggle.addEventListener("click", toggleMenu, false);
  }

  function toggleMenu() {
    document.getElementById("dashboard-content").classList.toggle("collapse");
    document.getElementById("dashboard-menu").classList.toggle("collapse");
  };

  var typed = new Typed('#things-i-do', {
    strings: ["^1000 Video Game ^3000", "^1000 Website ^3000", "^1000 Software ^3000"],
	  typeSpeed: 60,
		backSpeed: 80,
		loop: true,
  });
});

