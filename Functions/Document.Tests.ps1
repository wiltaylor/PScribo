﻿$here = Split-Path -Path $MyInvocation.MyCommand.Path -Parent;
$moduleRoot = Split-Path -Path $here -Parent;
Import-Module "$moduleRoot\PScribo.psm1" -Force;

InModuleScope 'PScribo' {

    Describe 'Document' {

        It 'returns a PSCustomObject object.' {
            $document = Document -Name 'Test Document' -ScriptBlock { };
            $document.GetType().Name | Should Be 'PSCustomObject';
        }

        It 'creates a PScribo.Document type.' {
            $document = Document -Name 'Test Document' -ScriptBlock { };
            $document.Type | Should Be 'PScribo.Document';
        }

        It 'creates a Document by named -Name parameter.' {
            $document = Document -Name 'Test Document' -ScriptBlock { };
            $document.Name | Should BeExactly 'Test Document';
        }

        It 'default Document.Options type should be hashtable.' {
            $document = Document -Name 'Test Document' -ScriptBlock { };
            $document.Options.GetType() | Should Be 'Hashtable';
        }

        It 'default Document.Styles type should be hashtable.' {
            $document = Document -Name 'Test Document' -ScriptBlock { };
            $document.Styles.GetType() | Should Be 'Hashtable';
        }

        It 'default Document.Style should be named "Normal".' {
            $document = Document -Name 'Test Document' -ScriptBlock { };
            $document.DefaultStyle | Should BeExactly 'Normal';
        }

        It 'default Document.TableStyle should be named "TableDefault".' {
            $document = Document -Name 'Test Document' -ScriptBlock { };
            $document.DefaultTableStyle | Should BeExactly 'TableDefault';
        }

        It 'creates a Document by positional -Name and -ScriptBlock parameters.' {
            $document = Document 'Test Document' { };
            $document.Name | Should BeExactly 'Test Document';
        }

        It 'creates a concatenated document Id by positional -Name and -ScriptBLock parameters.' {
            $document = Document 'Test Document' { };
            $document.Id | Should BeExactly 'TESTDOCUMENT';
        }

    } #end describe Document

} #end inmodulescope

<#
Code coverage report:
Covered 65.22% of 69 analyzed commands in 2 files.

Missed commands:

File                  Function                    Line Command
----                  --------                    ---- -------
Document.Internal.ps1 Process-PScriboSectionLevel   74 if ($pscriboDocument.Options['ForceUppercaseSection']) {...
Document.Internal.ps1 Process-PScriboSectionLevel   75 $Section.Name = $Section.Name.ToUpper()
Document.Internal.ps1 Process-PScriboSectionLevel   78 $Section.Number = $Number
Document.Internal.ps1 Process-PScriboSectionLevel   79 $Section.Level = $Number.Split('.').Count -1
Document.Internal.ps1 Process-PScriboSectionLevel   81 $tocEntry = [PScustomObject] @{ Id = $Section.Id; Number = $N...
Document.Internal.ps1 Process-PScriboSectionLevel   81 Id = $Section.Id
Document.Internal.ps1 Process-PScriboSectionLevel   81 Number = $Number
Document.Internal.ps1 Process-PScriboSectionLevel   81 Level = $Section.Level
Document.Internal.ps1 Process-PScriboSectionLevel   81 Name = $Section.Name
Document.Internal.ps1 Process-PScriboSectionLevel   82 [ref] $null = $pscriboDocument.TOC.Add($tocEntry)
Document.Internal.ps1 Process-PScriboSectionLevel   84 $minorNumber = 1
Document.Internal.ps1 Process-PScriboSectionLevel   85 $Section.Sections
Document.Internal.ps1 Process-PScriboSectionLevel   86 if ($s.Type -like '*.Section' -and -not $s.IsExcluded) {...
Document.Internal.ps1 Process-PScriboSectionLevel   87 $sectionNumber = ('{0}.{1}' -f $Number, $minorNumber).TrimSta...
Document.Internal.ps1 Process-PScriboSectionLevel   87 '{0}.{1}' -f $Number, $minorNumber
Document.Internal.ps1 Process-PScriboSectionLevel   88 Process-PScriboSectionLevel -Section $s -Number $sectionNumber
Document.Internal.ps1 Process-PScriboSectionLevel   89 $minorNumber++
Document.Internal.ps1 Process-PScriboSection        96 if ($s.Type -like '*.Section') {...
Document.Internal.ps1 Process-PScriboSection        97 if ($pscriboDocument.Options['ForceUppercaseSection']) {...
Document.Internal.ps1 Process-PScriboSection        98 $s.Name = $s.Name.ToUpper()
Document.Internal.ps1 Process-PScriboSection       100 if (-not $s.IsExcluded) {...
Document.Internal.ps1 Process-PScriboSection       101 Process-PScriboSectionLevel -Section $s -Number $majorNumber
Document.Internal.ps1 Process-PScriboSection       102 $majorNumber++
Document.ps1          Document                      27 [ref] $null = $pscriboDocument.Sections.Add($result)
#>