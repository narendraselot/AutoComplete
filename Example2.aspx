<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Example2.aspx.cs" Inherits="AutomComplete.Example2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
    <script src="layouts/JS/bootstrap3-typeahead.js"></script>
    <link href="https://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <script src="layouts/JS/jquery-1.9.1.js"></script>
    <script src="layouts/JS/typeScript.js"></script>
    <style>
        body {
            background-color: #fafafa;
            font-family: 'Roboto';
        }
        .container {
            margin: 150px auto;
            max-width: 600px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="container">
                <h1 id="h1MainHeader">jQuery Bootstrap 3/4 Typeahead Plugin Demo</h1>
                <input class="typeahead form-control">
            </div>
        </div>
        <script>
            var array = [];
            $(function () {
                getSuccessOutput();
            });
            function getSuccessOutput() {
                $.ajax({
                    url: './layouts/JS/zips.json',
                    async: false,
                    complete: function (response) {
                        obj = JSON.parse(response.responseText);
                        $(obj).each(function (index, data) {
                            array.push({ id: index, name: data.city });
                            //array.push({ name: data.city });
                        });
                        $("#h1MainHeader").html($("#h1MainHeader").html() + "<br>  Array Length : " + array.length);
                        initializeComponent();
                    },
                    error: function () {
                        $('#output').html('Bummer: there was an error! In Success');
                    },
                });
            }
            function initializeComponent() {
                var $input = $(".typeahead");
                $input.typeahead({
                    source: array,
                    autoSelect: true,
                    minLength: 3,
                    maxItem: 0,
                });
                $input.change(function () {
                    var current = $input.typeahead("getActive");
                    if (current) {
                        // Some item from your model is active!
                        if (current.name == $input.val()) {
                            // This means the exact match is found. Use toLowerCase() if you want case insensitive match.
                        } else {
                            // This means it is only a partial match, you can either add a new item
                            // or take the active if you don't want new items
                        }
                    } else {
                        // Nothing is active so it is a new value (or maybe empty value)
                    }
                });
            }
        </script>

    </form>
</body>
</html>
