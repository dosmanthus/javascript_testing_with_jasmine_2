/*globals define*/
define(function(){
  'use strict';
  var self = {};

  self.add = function add() {
    var operands = Array.prototype.slice.call(arguments),
        total = 0;
    operands.forEach(function(element) {
      if (typeof element === 'string') {
        element = parseInt(element, 10) || 0;
      }
      total += element;
    });

    return total;
  }

  return self;
});