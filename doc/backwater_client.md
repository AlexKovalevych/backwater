

# Module backwater_client #
* [Data Types](#types)
* [Function Index](#index)
* [Function Details](#functions)

<a name="types"></a>

## Data Types ##




### <a name="type-config">config()</a> ###


<pre><code>
config() = #{endpoint =&gt; <a href="#type-nonempty_binary">nonempty_binary()</a>, secret =&gt; binary(), hackney_opts =&gt; [<a href="#type-hackney_option">hackney_option()</a>], compression_threshold =&gt; non_neg_integer(), connect_timeout =&gt; timeout(), decode_unsafe_terms =&gt; boolean(), max_encoded_result_size =&gt; non_neg_integer(), recv_timeout =&gt; timeout(), rethrow_remote_exceptions =&gt; boolean()}
</code></pre>




### <a name="type-hackney_error">hackney_error()</a> ###


<pre><code>
hackney_error() = {hackney, term()}
</code></pre>




### <a name="type-hackney_option">hackney_option()</a> ###


<pre><code>
hackney_option() = <a href="proplists.md#type-property">proplists:property()</a>
</code></pre>

there's no remote type available; check hackney documentation



### <a name="type-result">result()</a> ###


<pre><code>
result() = <a href="backwater_http_response.md#type-t">backwater_http_response:t</a>(<a href="#type-hackney_error">hackney_error()</a> | not_started)
</code></pre>

<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#call-4">call/4</a></td><td></td></tr><tr><td valign="top"><a href="#start-2">start/2</a></td><td></td></tr><tr><td valign="top"><a href="#stop-1">stop/1</a></td><td></td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="call-4"></a>

### call/4 ###

<pre><code>
call(Ref, Module, Function, Args) -&gt; Result | no_return()
</code></pre>

<ul class="definitions"><li><code>Ref = term()</code></li><li><code>Module = module()</code></li><li><code>Function = atom()</code></li><li><code>Args = [term()]</code></li><li><code>Result = <a href="#type-result">result()</a></code></li></ul>

<a name="start-2"></a>

### start/2 ###

<pre><code>
start(Ref, Config) -&gt; ok | {error, Error}
</code></pre>

<ul class="definitions"><li><code>Ref = term()</code></li><li><code>Config = <a href="#type-config">config()</a></code></li><li><code>Error = already_started | <a href="backwater_util.md#type-config_validation_error">backwater_util:config_validation_error()</a></code></li></ul>

<a name="stop-1"></a>

### stop/1 ###

<pre><code>
stop(Ref) -&gt; ok | {error, not_found}
</code></pre>

<ul class="definitions"><li><code>Ref = term()</code></li></ul>
