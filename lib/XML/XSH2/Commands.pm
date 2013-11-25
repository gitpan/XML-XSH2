# This file was automatically generated from src/xsh_grammar.xml on 
# Mon Nov 25 13:10:37 2013
package XML::XSH2::Functions;

%COMMANDS = (
'eval' => ['run_exp', 1, 1,undef],
'settings' => ['list_flags', 0, 0,
	{
	 'v' => 'variables',
	 'variables' => '',
	}],
'defs' => ['list_defs', 0, 0,undef],
'ifinclude' => ['include', 1, 1,
	{
	 'e' => 'encoding',
	 'encoding' => 'string',
	}, 1],
'.' => 'include',
'include' => ['include', 1, 1,
	{
	 'e' => 'encoding',
	 'encoding' => 'string',
	}],
'apropos' => ['apropos', 1, 1,
	{
	 'r' => 'regexp',
	 'regexp' => '',
	 'f' => 'fulltext',
	 'fulltext' => '',
	}],
'help' => ['help', 0, 1,undef],
'system' => 'exec',
'exec' => ['sh', 1, undef,undef],
'transform' => 'xslt',
'xsl' => 'xslt',
'xsltproc' => 'xslt',
'process' => 'xslt',
'xslt' => ['xslt', 1, undef,
	{
	 'd' => 'doc',
	 'doc' => '',
	 's' => 'string',
	 'string' => '',
	 'c' => 'compile',
	 'compile' => '',
	 'p' => 'precompiled',
	 'precompiled' => '',
	}],
'files' => 'documents',
'docs' => 'documents',
'documents' => ['files', 0, 0,undef],
'set_filename' => ['set_filename', 1, 2,undef],
'vars' => 'variables',
'var' => 'variables',
'variables' => ['variables', 0, 0,undef],
'cp' => 'copy',
'copy' => ['copy', 3, 3,
	{
	 'r' => 'respective',
	 'respective' => '',
	}, 0],
'xcp' => 'xcopy',
'xcopy' => ['copy', 3, 3,
	{
	 'r' => 'respective',
	 'respective' => '',
	 'p' => 'preserve-order',
	 'preserve-order' => '',
	}, 1],
'chdir' => 'lcd',
'lcd' => ['cd', 0, 1,undef],
'add' => 'insert',
'insert' => ['insert', 4, 4,
	{
	 'n' => 'namespace',
	 'namespace' => 'exp',
	}, 0],
'wrap' => ['wrap', 2, 2,
	{
	 'n' => 'namespace',
	 'namespace' => 'exp',
	 'W' => 'while',
	 'while' => 'xpath',
	 'U' => 'until',
	 'until' => 'xpath',
	 'w' => 'skip-whitespace',
	 'skip-whitespace' => '',
	 'c' => 'skip-comments',
	 'skip-comments' => '',
	 'p' => 'skip-pi',
	 'skip-pi' => '',
	 'i' => 'inner',
	 'inner' => '',
	}],
'wrap_span' => 'wrap-span',
'wrap-span' => ['wrap_span', 3, 3,
	{
	 'n' => 'namespace',
	 'namespace' => 'exp',
	}],
'xadd' => 'xinsert',
'xinsert' => ['insert', 4, 4,
	{
	 'n' => 'namespace',
	 'namespace' => 'exp',
	}, 1],
'mv' => 'move',
'move' => ['move', 3, 3,
	{
	 'r' => 'respective',
	 'respective' => '',
	}, 0],
'xmv' => 'xmove',
'xmove' => ['move', 3, 3,
	{
	 'r' => 'respective',
	 'respective' => '',
	 'p' => 'preserve-order',
	 'preserve-order' => '',
	}, 1],
'dup' => 'clone',
'clone' => ['clone', 0, 1,undef],
'normalize' => ['normalize_nodes', 1, 1,undef],
'strip_whitespace' => 'strip-whitespace',
'strip-whitespace' => ['strip_ws', 1, 1,undef],
'list' => 'ls',
'ls' => ['list', 0, 1,
	{
	 'f' => 'fold',
	 'fold' => '',
	 'A' => 'fold-attrs',
	 'fold-attrs' => '',
	 'i' => 'indent',
	 'indent' => '',
	 'I' => 'no-indent',
	 'no-indent' => '',
	 'd' => 'depth',
	 'depth' => 'exp',
	}],
'canonical' => ['c14n', 0, 1,
	{
	 'c' => 'comments',
	 'comments' => '',
	 'f' => 'filter',
	 'filter' => 'xpath',
	}],
'count' => ['print_count', 1, 1,
	{
	 'q' => 'quiet',
	 'quiet' => '',
	}],
'change-ns-uri' => ['change_namespace_uri', 1, 2,undef],
'change-ns-prefix' => ['change_namespace_prefix', 1, 2,undef],
'set-ns' => ['set_namespace', 1, 2,
	{
	 'p' => 'prefix',
	 'prefix' => 'string',
	}],
'declare-ns' => ['declare_namespace', 2, 2,undef],
'set' => ['xpath_set', 1, 2,undef],
'exp' => 'get',
'expr' => 'get',
'get' => ['expr', 1, 1,undef],
'perl' => ['perl_eval_command', 1, 1,undef],
'rm' => 'remove',
'prune' => 'remove',
'delete' => 'remove',
'del' => 'remove',
'remove' => ['prune', 1, 1,undef],
'echo' => 'print',
'print' => ['echo', 0, undef,
	{
	 'n' => 'nonl',
	 'nonl' => '',
	 's' => 'nospace',
	 'nospace' => '',
	 'e' => 'stderr',
	 'stderr' => '',
	}],
'sort' => ['perlsort', 1, 1,
	{
	 'c' => 'compare',
	 'compare' => 'perl',
	 'k' => 'key',
	 'key' => 'exp',
	 'n' => 'numeric',
	 'numeric' => '',
	 'l' => 'locale',
	 'locale' => '',
	 'd' => 'descending',
	 'descending' => '',
	}],
'map' => ['perlmap', 2, 2,
	{
	 'i' => 'in-place',
	 'in-place' => '',
	 'r' => 'reverse',
	 'reverse' => '',
	}],
'rename' => ['perlrename', 2, 2,
	{
	 'n' => 'namespace',
	 'namespace' => 'exp',
	 'i' => 'in-place',
	 'in-place' => '',
	 'r' => 'reverse',
	 'reverse' => '',
	}],
'hash' => ['hash', 2, 2,undef],
'close' => ['close_doc', 0, 1,undef],
'index' => ['index_doc', 0, 1,undef],
'open' => ['open_doc', 1, 1,
	{
	 'F' => 'format',
	 'format' => 'string',
	 'f' => 'file',
	 'file' => '',
	 'p' => 'pipe',
	 'pipe' => '',
	 's' => 'string',
	 'string' => '',
	 'w' => 'switch-to',
	 'switch-to' => '',
	 'W' => 'no-switch-to',
	 'no-switch-to' => '',
	 'v' => 'validate',
	 'validate' => '',
	 'V' => 'no-validate',
	 'no-validate' => '',
	 'r' => 'recover',
	 'recover' => '',
	 'R' => 'no-recover',
	 'no-recover' => '',
	 'e' => 'expand-entities',
	 'expand-entities' => '',
	 'E' => 'no-expand-entities',
	 'no-expand-entities' => '',
	 'x' => 'xinclude',
	 'xinclude' => '',
	 'X' => 'no-xinclude',
	 'no-xinclude' => '',
	 'b' => 'keep-blanks ',
	 'keep-blanks ' => '',
	 'B' => 'no-keep-blanks ',
	 'no-keep-blanks ' => '',
	 'n' => 'pedantic ',
	 'pedantic ' => '',
	 'N' => 'no-pedantic ',
	 'no-pedantic ' => '',
	 'd' => 'load-ext-dtd ',
	 'load-ext-dtd ' => '',
	 'D' => 'no-load-ext-dtd ',
	 'no-load-ext-dtd ' => '',
	 'a' => 'complete-attributes',
	 'complete-attributes' => '',
	 'A' => 'no-complete-attributes',
	 'no-complete-attributes' => '',
	}],
'new' => 'create',
'create' => ['new_doc', 1, 1,
	{
	 'F' => 'format',
	 'format' => 'string',
	}],
'save' => ['save_doc', 0, 1,
	{
	 'F' => 'format',
	 'format' => 'string',
	 'x' => 'xinclude',
	 'xinclude' => '',
	 'f' => 'file',
	 'file' => 'string',
	 'p' => 'pipe',
	 'pipe' => 'string',
	 'S' => 'subtree',
	 'subtree' => '',
	 'r' => 'print',
	 'print' => '',
	 's' => 'string',
	 'string' => '',
	 'i' => 'indent',
	 'indent' => '',
	 'I' => 'no-indent',
	 'no-indent' => '',
	 'd' => 'skip-dtd',
	 'skip-dtd' => '',
	 'D' => 'no-skip-dtd',
	 'no-skip-dtd' => '',
	 'x' => 'skip-xmldecl',
	 'skip-xmldecl' => '',
	 'X' => 'no-skip-xmldecl',
	 'no-skip-xmldecl' => '',
	 't' => 'skip-empty-tags',
	 'skip-empty-tags' => '',
	 'T' => 'no-skip-empty-tags',
	 'no-skip-empty-tags' => '',
	 'b' => 'backup',
	 'backup' => '',
	 'B' => 'backups',
	 'backups' => '',
	 'e' => 'encoding',
	 'encoding' => 'string',
	}],
'set_dtd' => 'set-dtd',
'set-dtd' => ['set_dtd', 0, 1,
	{
	 'n' => 'name',
	 'name' => 'string',
	 's' => 'system',
	 'system' => 'string',
	 'p' => 'public',
	 'public' => 'public',
	}],
'dtd' => ['list_dtd', 0, 1,undef],
'set-enc' => ['set_doc_enc', 1, 2,undef],
'set-standalone' => ['set_doc_standalone', 1, 2,undef],
'enc' => ['print_enc', 0, 1,undef],
'validate' => ['validate_doc', 0, 1,
	{
	 'q' => 'yesno',
	 'yesno' => '',
	 'D' => 'dtd',
	 'dtd' => '',
	 'R' => 'relaxng',
	 'relaxng' => '',
	 'S' => 'schema',
	 'schema' => '',
	 'f' => 'file',
	 'file' => 'string',
	 's' => 'string',
	 'string' => 'exp',
	 'p' => 'public',
	 'public' => 'exp',
	 'd' => 'doc',
	 'doc' => 'exp',
	}],
'quit' => 'exit',
'exit' => ['quit', 0, 1,undef],
'process_xinclude' => 'process-xinclude',
'process-xincludes' => 'process-xinclude',
'process_xincludes' => 'process-xinclude',
'xinclude' => 'process-xinclude',
'xincludes' => 'process-xinclude',
'load_xincludes' => 'process-xinclude',
'load-xincludes' => 'process-xinclude',
'load_xinclude' => 'process-xinclude',
'load-xinclude' => 'process-xinclude',
'process-xinclude' => ['process_xinclude', 0, 1,undef],
'chxpath' => 'cd',
'cd' => ['set_local_xpath', 0, 1,undef],
'pwd' => ['print_pwd', 0, 0,
	{
	 'i' => 'id',
	 'id' => '',
	}],
'locate' => ['locate', 0, 1,
	{
	 'i' => 'id',
	 'id' => '',
	}],
'xupdate' => ['xupdate', 1, 2,undef],
'verbose' => ['set_quiet', 0, 0,undef, 0],
'debug' => ['set_debug', 0, 0,undef, 1],
'nodebug' => ['set_debug', 0, 0,undef, 0],
'version' => ['print_version', 0, 0,undef, 0],
'validation' => ['set_validation', 1, 1,undef],
'recovering' => ['set_recovering', 1, 1,undef],
'parser_expands_entities' => 'parser-expands-entities',
'parser-expands-entities' => ['set_expand_entities', 1, 1,undef],
'keep_blanks' => 'keep-blanks',
'keep-blanks' => ['set_keep_blanks', 1, 1,undef],
'pedantic_parser' => 'pedantic-parser',
'pedantic-parser' => ['set_pedantic_parser', 1, 1,undef],
'complete_attributes' => 'parser-completes-attributes',
'complete-attributes' => 'parser-completes-attributes',
'parser_completes_attributes' => 'parser-completes-attributes',
'parser-completes-attributes' => ['set_complete_attributes', 1, 1,undef],
'indent' => ['set_indent', 1, 1,undef],
'empty_tags' => 'empty-tags',
'empty-tags' => ['set_empty_tags', 1, 1,undef],
'skip_dtd' => 'skip-dtd',
'skip-dtd' => ['set_skip_dtd', 1, 1,undef],
'parser_expands_xinclude' => 'parser-expands-xinclude',
'parser-expands-xinclude' => ['set_expand_xinclude', 1, 1,undef],
'load_ext_dtd' => 'load-ext-dtd',
'load-ext-dtd' => ['set_load_ext_dtd', 1, 1,undef],
'encoding' => ['set_encoding', 1, 1,undef],
'query_encoding' => 'query-encoding',
'query-encoding' => ['set_qencoding', 1, 1,undef],
'quiet' => ['set_quiet', 0, 0,undef, 1],
'switch_to_new_documents' => 'switch-to-new-documents',
'switch-to-new-documents' => ['set_cdonopen', 1, 1,undef],
'backups' => ['set_backups', 0, 0,undef, 1],
'nobackups' => ['set_backups', 0, 0,undef, 0],
'fold' => ['mark_fold', 0, 1,
	{
	 'd' => 'depth',
	 'depth' => 'exp',
	}],
'unfold' => ['mark_unfold', 1, 1,undef],
'redo' => ['loop_redo', 0, 1,undef],
'next' => ['loop_next', 0, 1,undef],
'prev' => ['loop_prev', 0, 1,undef],
'last' => ['loop_last', 0, 1,undef],
'return' => ['call_return', 0, 1,undef],
'throw' => ['throw_exception', 1, 1,undef],
'catalog' => ['load_catalog', 1, 1,undef],
'regns' => 'register-namespace',
'register-namespace' => ['register_ns', 2, 2,undef],
'unregns' => 'unregister-namespace',
'unregister-namespace' => ['unregister_ns', 1, 1,undef],
'regns-xhtml' => 'register-xhtml-namespace',
'register-xhtml-namespace' => ['register_xhtml_ns', 1, 1,undef],
'regns-xsh' => 'register-xsh-namespace',
'register-xsh-namespace' => ['register_xsh_ns', 1, 1,undef],
'function' => 'register-function',
'regfunc' => 'register-function',
'register-function' => ['register_func', 2, 2,undef],
'unregfunc' => 'unregister-function',
'unregister-function' => ['unregister_func', 1, 1,undef],
'namespaces' => ['list_namespaces', 0, 1,
	{
	 'r' => 'registered',
	 'registered' => '',
	}],
'xpath_completion' => 'xpath-completion',
'xpath-completion' => ['set_xpath_completion', 1, 1,undef],
'xpath_axis_completion' => 'xpath-axis-completion',
'xpath-axis-completion' => ['set_xpath_axis_completion', 1, 1,undef],
'doc_info' => 'doc-info',
'doc-info' => ['doc_info', 0, 1,undef],
'xpath_extensions' => 'xpath-extensions',
'xpath-extensions' => ['xpath_extensions', 0, 1,undef],
'lineno' => ['print_lineno', 0, 1,undef],
'edit-string' => ['edit', 1, 1,
	{
	 'E' => 'editor',
	 'editor' => 'string',
	 'e' => 'encoding',
	 'encoding' => 'string',
	 '0' => 'allow-empty',
	 'allow-empty' => '',
	}, 1],
'edit' => ['edit', 0, 1,
	{
	 'E' => 'editor',
	 'editor' => 'string',
	 'A' => 'all',
	 'all' => '',
	 'n' => 'noindent',
	 'noindent' => '',
	 'r' => 'recover',
	 'recover' => '',
	 'k' => 'keep-blanks',
	 'keep-blanks' => '',
	 '0' => 'allow-empty',
	 'allow-empty' => '',
	 'q' => 'no-comment',
	 'no-comment' => '',
	 'e' => 'encoding',
	 'encoding' => 'string',
	}],
'call' => ['call_command', 1, undef,undef],
);

1;
