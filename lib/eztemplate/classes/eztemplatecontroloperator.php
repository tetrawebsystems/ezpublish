<?php
//
// Definition of eZTemplateControlOperator class
//
// Created on: <18-Apr-2002 12:15:07 amos>
//
// Copyright (C) 1999-2004 eZ systems as. All rights reserved.
//
// This source file is part of the eZ publish (tm) Open Source Content
// Management System.
//
// This file may be distributed and/or modified under the terms of the
// "GNU General Public License" version 2 as published by the Free
// Software Foundation and appearing in the file LICENSE.GPL included in
// the packaging of this file.
//
// Licencees holding valid "eZ publish professional licences" may use this
// file in accordance with the "eZ publish professional licence" Agreement
// provided with the Software.
//
// This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING
// THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE.
//
// The "eZ publish professional licence" is available at
// http://ez.no/products/licences/professional/. For pricing of this licence
// please contact us via e-mail to licence@ez.no. Further contact
// information is available at http://ez.no/home/contact/.
//
// The "GNU General Public License" (GPL) is available at
// http://www.gnu.org/copyleft/gpl.html.
//
// Contact licence@ez.no if any conditions of this licencing isn't clear to
// you.
//

/*!
  \class eZTemplateControlOperator eztemplatetypeoperator.php
  \ingroup eZTemplateOperators
  \brief Operators for checking variable type

Usage:
// Evalue condition and if true return body
cond(is_set($var),$var,
     true(),2)
// Return first element that is set
first_set($var1,$var2,$var3,0)

*/

class eZTemplateControlOperator
{
    /*!
     Initializes the operator class with the various operator names.
    */
    function eZTemplateControlOperator(  /*! The name array */
        $condName = 'cond',
        $firstSetName = 'first_set' )
    {
        $this->Operators = array( $condName, $firstSetName );
        $this->CondName = $condName;
        $this->FirstSetName = $firstSetName;
    }

    /*!
     Returns the operators in this class.
    */
    function &operatorList()
    {
        return $this->Operators;
    }

    function operatorTemplateHints()
    {
        return array( $this->CondName => array( 'input' => false,
                                                'output' => true,
                                                'parameters' => true,
                                                'element-transformation' => true,
                                                'transform-parameters' => true,
                                                'input-as-parameter' => false,
                                                'element-transformation-func' => 'condTransform' ),
                      $this->FirstSetName => array( 'input' => false,
                                                    'output' => true,
                                                    'parameters' => true,
                                                    'element-transformation' => true,
                                                    'transform-parameters' => true,
                                                    'input-as-parameter' => false,
                                                    'element-transformation-func' => 'condTransform' ) );
    }

    /*!
     \reimp
    */
    function condTransform( $operatorName, &$node, &$tpl, &$resourceData,
                            &$element, &$lastElement, &$elementList, &$elementTree, &$parameters )
    {
        switch( $operatorName )
        {
            case $this->CondName:
            {
                $paramCount = count( $parameters );
                $clauseCount = floor( $paramCount / 2 );

                $values = array();
                $code = '';
                for ( $i = 0; $i < $clauseCount; ++$i )
                {
                    if ( !eZTemplateNodeTool::isStaticElement( $parameters[$i*2] ) )
                    {
                        if ( $i != 0 )
                        {
                            $code .= 'else ';
                        }

                        $values[] = $parameters[$i*2];
                        $code .= 'if ( %' . count( $values ) . '% )' . "\n";
                    }
                    else
                    {
                        if ( eZTemplateNodeTool::elementStaticValue( $parameters[$i*2] ) )
                        {
                            if ( eZTemplateNodeTool::isStaticElement( $parameters[$i*2 + 1] ) )
                            {
                                return array( $parameters[$i*2 + 1] );
                            }
                            else
                            {
                                if ( $i != 0 )
                                {
                                    $code .= 'else ';
                                }

                                $values[] = $parameters[$i*2 + 1];
                                $code .= '%output% = %' . count( $values ) . '%;';
                                break;
                            }
                        }

                        continue;
                    }

                    if ( !eZTemplateNodeTool::isStaticElement( $parameters[$i*2 + 1] ) )
                    {
                        $values[] = $parameters[$i*2 + 1];
                        $code .= '%output% = %' . count( $values ) . '%;' . "\n";
                    }
                    else
                    {
                        $code .= '%output% = ' . eZPHPCreator::variableText( eZTemplateNodeTool::elementStaticValue( $parameters[$i*2 + 1] ), 0, 0, false ) . ';' . "\n";
                    }
                }

                return array( eZTemplateNodeTool::createCodePieceElement( $code, $values ) );
            } break;

            case $this->FirstSetName:
            {
                $values = array();
                $code = '';
                for( $i = 0; $i < count( $parameters ); ++$i )
                {
                    if ( $i != 0 )
                    {
                        $code .= "}\nelse\n{\n";
                    }

                    if ( eZTemplateNodeTool::isStaticElement( $parameters[$i] ) )
                    {
                        $code .= "\t%output% = " . eZPHPCreator::variableText( eZTemplateNodeTool::elementStaticValue( $parameters[$i] ), 0, 0, false ) . ";\n";
                        break;
                    }

                    $values[] = $parameters[$i];
                    $code .= 'if ( isset( %' . count( $values ) . "% ) )\n{\n\t%output% = %" . count( $values ) . '%;' . "\n";
                }
                $code .= "}\n";

                return array( eZTemplateNodeTool::createCodePieceElement( $code, $values ) );
            } break;
        }
    }

    /*!
     \return true to tell the template engine that the parameter list exists per operator type.
    */
    function namedParameterPerOperator()
    {
        return true;
    }

    /*!
     See eZTemplateOperator::namedParameterList
    */
    function namedParameterList()
    {
        return array();
    }

    /*!
     Examines the input value and outputs a boolean value. See class documentation for more information.
    */
    function modify( &$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$value, &$namedParameters )
    {
        switch ( $operatorName )
        {
            case $this->CondName:
            {
                $parameterCount = count( $operatorParameters );
                $clauseCount = floor( $parameterCount / 2 );
                $clauseMod = $parameterCount % 2;
                $conditionSuccess = false;
                for ( $i = 0; $i < $clauseCount; ++$i )
                {
                    $condition =& $tpl->elementValue( $operatorParameters[$i*2], $rootNamespace, $currentNamespace );
                    if ( $condition )
                    {
                        $body =& $tpl->elementValue( $operatorParameters[$i*2 + 1], $rootNamespace, $currentNamespace );
                        $conditionSuccess = true;
                        $value = $body;
                        break;
                    }
                }
                if ( !$conditionSuccess and
                     $clauseMod > 0 )
                {
                    $condition =& $tpl->elementValue( $operatorParameters[count($operatorParameters) - 1], $rootNamespace, $currentNamespace );
                    if ( $condition )
                    {
                        $conditionSuccess = true;
                        $value = $condition;
                    }
                }
            } break;
            case $this->FirstSetName:
            {
                if ( count( $operatorParameters ) > 0 )
                {
                    for ( $i = 0; $i < count( $operatorParameters ); ++$i )
                    {
                        $operand =& $tpl->elementValue( $operatorParameters[$i], $rootNamespace, $currentNamespace, false, true );
                        if ( $operand != false )
                        {
                            $value = $operand;
                            return;
                        }
                    }
                }
                $value = null;
            } break;
        }
    }

    /// The array of operators
    var $Operators;
};

?>
