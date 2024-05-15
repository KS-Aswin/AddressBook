$(document).ready(function () {
   // Event bindings
   $("#email").on("input", validateEmailInput);
   $("#password, #cPassword").on("input", validatePasswordInput);
   $("#address").on("input", validateAddressInput);
   $("#firstName, #lastName").on("keypress", preventNumbers);
   $("#firstName, #lastName, #address").on("keypress", preventSpecialCharacters);
   $("#phone").on("keypress", preventNonNumeric).on("input", limitLength);
   $("#registerButton").on("click", validateForm);

   // Function definitions
   function validateEmailInput() {
      var email = $(this).val().trim();
      if (validateEmail(email)) {
         $("#mail").hide();
      }
   }

   function validatePasswordInput() {
      var password = $("#password").val().trim();
      var cPassword = $("#cPassword").val().trim();

      if (password !== cPassword) {
         $("#cpass").text("Passwords do not match.").show();
      } else {
         $("#pass, #cpass").hide();
      }

      if (!validatePasswordPolicy(password)) {
         $("#pass").text("Password must contain at least 8 characters, including digits and special characters.").show();
      } else {
         $("#pass").hide();
      }
   }

   function validateAddressInput() {
      var address = $(this).val().trim();
      if (!containsLettersNumber(address)) {
         $("#add").text("Enter An Address.").show();
      } else {
         $("#add").hide();
      }
   }

   function validateForm() {
      var firstName = $("#firstName").val().trim();
      var lastName = $("#lastName").val().trim();
      var address = $("#address").val().trim();
      var phone = $("#phone").val().trim();
      var email = $("#email").val().trim();
      var password = $("#password").val().trim();
      var cPassword = $("#cPassword").val().trim();

      $(".pTag").hide();

      if (firstName == "" || firstName.length <= 1) {
         $("#fname").text("Enter a First Name!..").show();
      }

      if (lastName == "") {
         $("#lname").text("Enter a Last Name!..").show();
      }

      if (address == "" || containsOnlyNumbers(address)) {
         $("#add").text("Entere an Address containing Letters!..").show();
      }

      if (phone == "" || phone.length < 10) {
         $("#ph").text("Enter a Phone Number!..").show();
      }

      if (email == "") {
         $("#mail").text("Enter an Email Address!..").show();
      }

      if (password == "") {
         $("#pass").text("Enter a Password!..").show();
      }

      if (cPassword == "") {
         $("#cpass").text("Enter the Confirm Password!..").show();
      }

      if (!validateEmail(email)) {
         $("#mail").text("Enter a valid email address!..").show();
         return false;
      }

      if (password !== cPassword) {
         $("#pass").text("Passwords do not match.").show();
         return false;
      }

      if (!validatePasswordPolicy(password)) {
         $("#pass").text("Password must contain at least 8 characters, including digits and special characters.").show();
         return false;
      }

      if (firstName !== "" && lastName !== "" && address !== "" && phone !== "" && email !== "" && password !== "" && cPassword !== "" && validateEmail(email) && password === cPassword) {
         alert("Registration completed!");
      }
   }

   function preventNumbers(event) {
      if (event.keyCode >= 48 && event.keyCode <= 57) {
         return false;
      }
   }

   function preventSpecialCharacters(event) {
      var charCode = event.which || event.keyCode;
      var charStr = String.fromCharCode(charCode);
      var allowedChars = /^[a-zA-Z0-9\s]+$/;
      return allowedChars.test(charStr);
   }

   function preventNonNumeric(event) {
      var charCode = event.which || event.keyCode;
      var charStr = String.fromCharCode(charCode);
      var allowedNumbers = /^[0-9]+$/;
      return allowedNumbers.test(charStr);
   }


   function limitLength(event) {
      var input = event.target.value;
      if (input.length >= 10) {
         event.preventDefault();
         event.target.value = input.substring(0, 10);
      }
   }

   function validateEmail(email) {
      var emailRegex = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/;
      return emailRegex.test(email);
   }

   function containsLettersNumber(str) {
      return /^[a-zA-Z0-9\s]+$/.test(str);
   }

   function containsOnlyNumbers(str) {
      return /^\d+$/.test(str);
   }

   function validatePasswordPolicy(password) {
      var passwordRegex = /^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-zA-Z]).{8,}$/;
      return passwordRegex.test(password);
   }
});