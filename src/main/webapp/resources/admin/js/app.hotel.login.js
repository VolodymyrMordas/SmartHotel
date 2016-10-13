$(function(){
   console.log('login js');
   $('#login-form').ajaxForm({
      //dataType : 'json',
      success: function() {
         location.reload();
      }
   });
});