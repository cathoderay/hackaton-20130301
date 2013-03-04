#/usr/bin/perl
use Mojolicious::Lite;
use Core qw(get_json);


get '/' => 'index';
get '/json' => sub {
    my $self = shift;
    my $query = $self->param('query'); 
    return $self->render_json(get_json $query);
}; 
app->start


__DATA__
@@ index.html.ep
<!DOCTYPE html>
<html>
<head>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="http://underscorejs.org/underscore.js"></script>
    <script src="http://www.flotcharts.org/flot/jquery.flot.js"></script>
    <script src="http://www.flotcharts.org/flot/jquery.flot.time.js"></script>

</head>

<body>
    <style>
        body { text-align: center; }
        #graph {margin-left: auto; margin-right: auto; width: 700px; height: 500px;}
        #query {width: 400px; height: 60px}
    </style>

    <script>
        function to_numbers(array) {
            console.debug(array);
            return _.map(array, Number);
        }

        function plot(query) {
            $.getJSON('/json?query=' + query, function(data) {
                data = _.map($.parseJSON(data), to_numbers);
                $.plot("#graph", [data], {});
            });
        }
        
        function add_listener() {
            $('input#doplot').click(function() {
                var query = $('textarea#query').val();
                plot(query); 
            });
        }

        $(document).ready(function() { 
            add_listener();
            $('input#doplot').click();
        });

    </script>
    <h1>vsdash</h1>

    <form>
        <textarea id="query">select ts, value from mytable</textarea>
        <input id='doplot' type='button' value='plot!'/>
    </form>

    <div id="graph"></div>
</body>
</html>
