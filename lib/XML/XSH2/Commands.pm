# This file was automatically generated from src/xsh_grammar.xml on 
# Sat Dec  4 22:00:04 2004
package XML::XSH2::Functions;

%COMMANDS = (
'eval' => [\&run_exp, 1, 1],
'settings' => [\&list_flags, 0, 0],
'defs' => [\&list_defs, 0, 0],
'ifinclude' => [\&include, 1, 1,
	{
	 'e' => 'encoding',
	 'encoding' => 'string',
	}, 1],
'.' => 'include',
'include' => [\&include, 1, 1,
	{
	 'e' => 'encoding',
	 'encoding' => 'string',
	}],
'?' => 'help',
'help' => [\&help, 0, 1],
'system' => 'exec',
'exec' => [\&sh, 1, undef],
'transform' => 'xslt',
'xsl' => 'xslt',
'xsltproc' => 'xslt',
'process' => 'xslt',
'xslt' => [\&xslt, 1, undef,
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
'documents' => [\&files, 0, 0],
'vars' => 'variables',
'var' => 'variables',
'variables' => [\&variables, 0, 0],
'cp' => 'copy',
'copy' => [\&copy, 3, 3,
	{
	 'r' => 'respective',
	 'respective' => '',
	}, 0],
'xcp' => 'xcopy',
'xcopy' => [\&copy, 3, 3,
	{
	 'r' => 'respective',
	 'respective' => '',
	}, 1],
'chdir' => 'lcd',
'lcd' => [\&cd, 0, 1],
'add' => 'insert',
'insert' => [\&insert, 4, 4,
	{
	 'n' => 'namespace',
	 'namespace' => 'exp',
	}, 0],
'wrap' => [\&wrap, 2, 2,
	{
	 'n' => 'namespace',
	 'namespace' => 'exp',
	}],
'wrap_span' => 'wrap-span',
'wrap-span' => [\&wrap_span, 3, 3,
	{
	 'n' => 'namespace',
	 'namespace' => 'exp',
	}],
'xadd' => 'xinsert',
'xinsert' => [\&insert, 4, 4,
	{
	 'n' => 'namespace',
	 'namespace' => 'exp',
	}, 1],
'mv' => 'move',
'move' => [\&move, 3, 3,
	{
	 'r' => 'respective',
	 'respective' => '',
	}, 0],
'xmv' => 'xmove',
'xmove' => [\&move, 3, 3,
	{
	 'r' => 'respective',
	 'respective' => '',
	}, 1],
'dup' => 'clone',
'clone' => [\&clone, 0, 1],
'normalize' => [\&normalize_nodes, 1, 1],
'strip_whitespace' => 'strip-whitespace',
'strip-whitespace' => [\&strip_ws, 1, 1],
'list' => 'ls',
'ls' => [\&list, 0, 1,
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
'canonical' => [\&c14n, 0, 1,
	{
	 'c' => 'comments',
	 'comments' => '',
	 'f' => 'filter',
	 'filter' => 'xpath',
	}],
'count' => [\&print_count, 1, 1,
	{
	 'q' => 'quiet',
	 'quiet' => '',
	}],
'exp' => 'get',
'expr' => 'get',
'get' => [\&_ev, 1, 1],
'perl' => [\&perl_eval, 1, 1],
'rm' => 'remove',
'prune' => 'remove',
'delete' => 'remove',
'del' => 'remove',
'remove' => [\&prune, 1, 1],
'echo' => 'print',
'print' => [\&echo, 0, undef,
	{
	 'n' => 'nonl',
	 'nonl' => '',
	}],
'sort' => [\&perlsort, 1, 1,
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
'sed' => 'map',
'map' => [\&perlmap, 2, 2],
'rename' => [\&perlrename, 2, 2],
'close' => [\&close_doc, 0, 1],
'index' => [\&index_doc, 0, 1],
'open' => [\&open_doc, 1, 1,
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
'create' => [\&new_doc, 1, 1,
	{
	 'F' => 'format',
	 'format' => 'string',
	}],
'save' => [\&save_doc, 0, 1,
	{
	 'F' => 'format',
	 'format' => 'string',
	 'x' => 'xinclude',
	 'xinclude' => '',
	 'f' => 'file',
	 'file' => 'string',
	 'p' => 'pipe',
	 'pipe' => 'string',
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
'set-dtd' => [\&set_dtd, 0, 1,
	{
	 'n' => 'name',
	 'name' => 'string',
	 's' => 'system',
	 'system' => 'string',
	 'p' => 'public',
	 'public' => 'public',
	}],
'dtd' => [\&list_dtd, 0, 1],
'set-enc' => [\&set_doc_enc, 1, 2],
'set-standalone' => [\&set_doc_standalone, 1, 2],
'enc' => [\&print_enc, 0, 1],
'validate' => [\&validate_doc, 0, 1,
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
'exit' => [\&quit, 0, 1],
'process_xinclude' => 'process-xinclude',
'process-xincludes' => 'process-xinclude',
'process_xincludes' => 'process-xinclude',
'xinclude' => 'process-xinclude',
'xincludes' => 'process-xinclude',
'load_xincludes' => 'process-xinclude',
'load-xincludes' => 'process-xinclude',
'load_xinclude' => 'process-xinclude',
'load-xinclude' => 'process-xinclude',
'process-xinclude' => [\&process_xinclude, 0, 1],
'chxpath' => 'cd',
'cd' => [\&set_local_xpath, 0, 1],
'pwd' => [\&print_pwd, 0, 0],
'locate' => [\&locate, 0, 1],
'xupdate' => [\&xupdate, 1, 2],
'verbose' => [\&set_quiet, 0, 0, 0],
'debug' => [\&set_debug, 0, 0, 1],
'nodebug' => [\&set_debug, 0, 0, 0],
'version' => [\&print_version, 0, 0, 0],
'validation' => [\&set_validation, 1, 1],
'recovering' => [\&set_recovering, 1, 1],
'parser_expands_entities' => 'parser-expands-entities',
'parser-expands-entities' => [\&set_expand_entities, 1, 1],
'keep_blanks' => 'keep-blanks',
'keep-blanks' => [\&set_keep_blanks, 1, 1],
'pedantic_parser' => 'pedantic-parser',
'pedantic-parser' => [\&set_pedantic_parser, 1, 1],
'complete_attributes' => 'parser-completes-attributes',
'complete-attributes' => 'parser-completes-attributes',
'parser_completes_attributes' => 'parser-completes-attributes',
'parser-completes-attributes' => [\&set_complete_attributes, 1, 1],
'indent' => [\&set_indent, 1, 1],
'empty_tags' => 'empty-tags',
'empty-tags' => [\&set_empty_tags, 1, 1],
'skip_dtd' => 'skip-dtd',
'skip-dtd' => [\&set_skip_dtd, 1, 1],
'parser_expands_xinclude' => 'parser-expands-xinclude',
'parser-expands-xinclude' => [\&set_expand_xinclude, 1, 1],
'load_ext_dtd' => 'load-ext-dtd',
'load-ext-dtd' => [\&set_load_ext_dtd, 1, 1],
'encoding' => [\&set_encoding, 1, 1],
'query_encoding' => 'query-encoding',
'query-encoding' => [\&set_qencoding, 1, 1],
'quiet' => [\&set_quiet, 0, 0, 1],
'switch_to_new_documents' => 'switch-to-new-documents',
'switch-to-new-documents' => [\&set_cdonopen, 1, 1],
'backups' => [\&set_backups, 0, 0, 1],
'nobackups' => [\&set_backups, 0, 0, 0],
'fold' => [\&mark_fold, 0, 1,
	{
	 'd' => 'depth',
	 'depth' => 'exp',
	}],
'unfold' => [\&mark_unfold, 1, 1],
'redo' => [\&loop_redo, 0, 1],
'next' => [\&loop_next, 0, 1],
'prev' => [\&loop_prev, 0, 1],
'last' => [\&loop_last, 0, 1],
'return' => [\&call_return, 0, 1],
'throw' => [\&throw_exception, 1, 1],
'catalog' => [\&load_catalog, 1, 1],
'regns' => 'register-namespace',
'register-namespace' => [\&register_ns, 2, 2],
'unregns' => 'unregister-namespace',
'unregister-namespace' => [\&unregister_ns, 1, 1],
'regns-xhtml' => 'register-xhtml-namespace',
'register-xhtml-namespace' => [\&register_xhtml_ns, 1, 1],
'regns-xsh' => 'register-xsh-namespace',
'register-xsh-namespace' => [\&register_xsh_ns, 1, 1],
'function' => 'register-function',
'regfunc' => 'register-function',
'register-function' => [\&register_func, 2, 2],
'unregfunc' => 'unregister-function',
'unregister-function' => [\&unregister_func, 1, 1],
'namespaces' => [\&list_namespaces, 0, 1],
'xpath_completion' => 'xpath-completion',
'xpath-completion' => [\&set_xpath_completion, 1, 1],
'xpath_axis_completion' => 'xpath-axis-completion',
'xpath-axis-completion' => [\&set_xpath_axis_completion, 1, 1],
'doc_info' => 'doc-info',
'doc-info' => [\&doc_info, 0, 1],
'xpath_extensions' => 'xpath-extensions',
'xpath-extensions' => [\&xpath_extensions, 0, 1],
'lineno' => [\&print_lineno, 0, 1],
'edit-string' => [\&edit, 1, 1,
	{
	 'E' => 'editor',
	 'editor' => 'string',
	 'e' => 'encoding',
	 'encoding' => 'string',
	 '0' => 'allow-empty',
	 'allow-empty' => '',
	}, 1],
'edit' => [\&edit, 0, 1,
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
'call' => [\&call_command, 1, undef],
);

1;
