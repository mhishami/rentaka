
var mobileField = new LiveValidation('mobile_no', { validMessage: "Number is good!" };
mobileField.add(validate.Format, {pattern, /\+\/d{10, 10}/ });

