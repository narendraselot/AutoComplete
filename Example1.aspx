<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Example1.aspx.cs" Inherits="AutomComplete.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link href="layouts/CSS/jquery-ui.css" rel="stylesheet" />
    <script src="layouts/JS/jquery-1.9.1.js"></script>
    <script src="layouts/JS/jquery-ui.min.js"></script>
    <title>Auto-Complete</title>
    <style>
        .ui-autocomplete {
            position: absolute;
            top: 0;
            left: 0;
            cursor: default;
            height: 400px;
            overflow: scroll;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <button type="button" onclick="getSuccessOutput()">Test Success</button>
            <button type="button" onclick="getFailOutput()">Test Failure</button>
            <div id="output">waiting for action</div>
            <div id="div-container" style="margin: 10px 10px; padding: 8px; width: 400px;" class="ui-widget ui-widget-content ui-corner-all">
                <div style="margin: 0 0 4px 4px;">Enter a City:</div>
                <input id="search" type="text" style="padding: 2px; font-size: .8em; width: 300px;" onkeypress="getSuccessOutput()" />
                <div style="margin: 20px 0 0 0;">
                    <span id="results" style="color: #68a;"></span>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    $(function () {
        getSuccessOutput();
    });
    // handles the click event, sends the query
    function getSuccessOutput() {
        if ($("#search").val().length > 2) {
            $.ajax({
                url: './layouts/JS/zips.json',
                complete: function (response) {
                    var array = [];
                    obj = JSON.parse(response.responseText);
                    $(obj).each(function (index, data) {
                        var newArray = [];
                        newArray.push(data.city);
                        array.push(newArray);
                    });
                    $("#output").html("Array Length : " + array.length);
                    $.widget('custom.mcautocomplete', $.ui.autocomplete, {
                        _create: function () {
                            this._super();
                            this.widget().menu("option", "items", "> :not(.ui-widget-header)");
                        },
                        _renderMenu: function (ul, items) {
                            var self = this,
                                thead;
                            if (this.options.showHeader) {
                                table = $('<div class="ui-widget-header" style="width:100%"></div>');
                                $.each(this.options.columns, function (index, item) {
                                    table.append('<span style="padding:0 4px;float:left;width:' + item.width + ';">' + item.name + '</span>');
                                });
                                table.append('<div style="clear: both;"></div>');
                                ul.append(table);
                            }
                            $.each(items, function (index, item) {
                                self._renderItem(ul, item);
                            });
                        },
                        _renderItem: function (ul, item) {
                            var t = '',
                                result = '';
                            $.each(this.options.columns, function (index, column) {
                                var whole_word = item[column.valueField ? column.valueField : index];
                                var current_search_string = document.getElementById("search").value;

                                // Highlight current search term.
                                var regex = new RegExp('(' +
                                    current_search_string + ')', 'gi');
                                whole_word = whole_word.replace(
                                    regex, "<b>$1</b>");

                                t += '<span style="padding:0 4px;float:left;width:' + column.width + ';">' + whole_word + '</span>';
                            });

                            result = $('<li></li>')
                                .data('ui-autocomplete-item', item)
                                .append('<a class="mcacAnchor">' + t + '<div style="clear: both;"></div></a>')
                                .appendTo(ul);
                            return result;
                        }
                    });

                    var columns = [
                        { name: 'city', width: '5.5em' },
                    ];
                    var colors = array;
                    // Sets up the multicolumn autocomplete widget.
                    $("#search").mcautocomplete({
                        // These next two options are what this plugin adds to the autocomplete widget.
                        showHeader: false,
                        columns: columns,
                        source: colors,
                        // Event handler for when a list item is selected.
                        select:
                        function (event, ui) {
                            var result_text = (ui.item)
                                ? ui.item[0] + ', ' + ui.item[1] + ', ' + ui.item[2]
                                : '';
                            // this.value = (ui.item ? (ui.item[0]  + ', ' + ui.item[1] + ', ' + ui.item[2]): '');
                            this.value = (ui.item ? ui.item[0] : '');
                            //$('#results').text(ui.item ? 'Selected: ' + ui.item[0] + ', ' + ui.item[1] + ', ' + ui.item[2] : 'Nothing selected, input was ' + this.value);
                            $("#results").text("Current item value : " + this.value);
                            return false;
                        },
                        minLength: 3
                    });
                },
                error: function () {
                    $('#output').html('Bummer: there was an error! In Success');
                },
            });
        }
    }
    // handles the click event, sends the query
    function getFailOutput() {
        $.ajax({
            url: './layouts/JS/zips.json',
            success: function (response) {
                console.log(data, response);
                $('#output').html(response);
                var array = [];

            },
            error: function () {
                $('#output').html('Bummer: there was an error! In FAILURE');
            },
        });
        return false;
    }
</script>

