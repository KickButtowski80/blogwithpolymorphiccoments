/** This enables editing for a given node. It will activate the contentEditable API for 
 * all elements with a `editable` class. This elements must have a property attribute which says what 
 * model attribute the field is editing. The elements must also have a src attribute which is a url
 * where the data is sent.
 */
'use strict';

var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ('value' in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError('Cannot call a class as a function'); } }

var enableEditing = function enableEditing(nodeId) {
  //alert(Number.isInteger(parseInt(nodeId)));
  if (Number.isInteger(parseInt(nodeId))) nodes = document.getElementById(nodeId).querySelectorAll('.editable');else nodes = document.querySelector(nodeId).querySelectorAll('.editable');
  nodes.forEach(function (node) {
    node.setAttribute('contentEditable', 'true');
    node.onfocus = function () {
      window.selectedEditor = node;
      window.editorToolbar = new editorToolbar(node);
    };
    node.onblur = function () {
      saveData(node);
      window.editorToolbar.toolbarElement.classList.remove('active');
    };
  });
  nodes[0].focus();
};

/**Save the data from the node. The node must have the following attributes:
 * _property_: the attribute name of the object in question. will be the key in the data sent
 * _src_: the API endpoint where the data is sent. should be the update controller this is sent with the PATCH verb, so use up to date browsers.
 * NOTE: this function appends the CSRF data using getCSRFParam(), so that functon should return the correct auth values.
 */
var saveData = function saveData(node) {

  var url = node.getAttribute('src');
  console.log(url);
  var data = new FormData();
  var request = new XMLHttpRequest();
  var csrfData = getCSRFParam();
  var editParam = node.getAttribute('property');
  console.log("edit params" + node.innerHTML);
  data.append(editParam, node.innerHTML);
  data.append(csrfData.paramName, csrfData.token);
  request.open("PUT", url);
  request.send(data);

  //document.getElementById('edit-toolbar').classList.remove('active')
};

/** get the correct cross-site request forgery prevention (CSRF) token and return it as an object for 
 * inserting into params sent to the server via AJAX. The value is cached once run, so if you
 * change the csrf header info after page load, you should update this method as well.
 * @return [Object] the params object, with paramName and token as keys
 */
var getCSRFParam = function getCSRFParam() {
  // cache csrf params so we don't have to look in the DOM more than once
  // we know we are using Rails, so we can safely assume the csrf values in the
  //   document header aren't going to change after page creation
  if (window.csrfParams) return window.csrfParams;
  var param = document.querySelector('meta[name="csrf-param"]').getAttribute('content');
  var token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  window.csrfParams = {
    paramName: param,
    token: token
  };
  return window.csrfParams;
};

var formatDoc = function formatDoc(cmd, val) {
  window.editorToolbar.formatDoc(cmd, val);
};

var editorToolbar = (function () {
  function editorToolbar(elem) {
    _classCallCheck(this, editorToolbar);

    this.elem = elem;
    this.toolbarElement = document.getElementById('edit-toolbar');
    this.attachToolbar();
  }

  _createClass(editorToolbar, [{
    key: 'attachToolbar',
    value: function attachToolbar() {
      var inserted_node = this.elem.parentNode.insertBefore(this.toolbarElement, this.elem);
      this.toolbarElement.classList.add('active');
    }
  }, {
    key: 'formatDoc',
    value: function formatDoc(sCmd, sValue) {
      if (this.validateMode()) {
        document.execCommand(sCmd, false, sValue);this.elem.focus();
      }
    }
  }, {
    key: 'validateMode',
    value: function validateMode() {
      if (!document.getElementById('switchBox').checked) {
        return true;
      }
      alert("Uncheck \"Show HTML\".");
      elem.focus();
      return false;
    }
  }]);

  return editorToolbar;
})();
