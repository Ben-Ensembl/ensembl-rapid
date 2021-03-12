=head1 LICENSE

Copyright [1999-2015] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute
Copyright [2016-2018] EMBL-European Bioinformatics Institute

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=cut

package EnsEMBL::Web::Component::Gene::ComparaHomologs;

use strict;

use base qw(EnsEMBL::Web::Component::Gene);

sub _init {
  my $self = shift;
  $self->cacheable(1);
  $self->ajaxable(1);
}

sub content {
  my $self         = shift;
  my $hub          = $self->hub;
  my $object       = $self->object;
  my $species_defs = $hub->species_defs;
  my $availability = $object->availability;

  my @homologues = (
    $object->get_homology_matches('ENSEMBL_HOMOLOGUES', 'homolog_bbh', undef, 'compara'),
  );
  #use Data::Dumper; 
  #$Data::Dumper::Maxdepth = 2;
  #warn ">>> FOUND HOMOLOGUES: ".Dumper(\@homologues);

  my ($html, $columns, @rows);

  $columns = [
      {key => 'ref',    title => 'Reference species', align => 'left', width => '30%', sort => 'html'},
      {key => 'type',   title => 'Type', align => 'left', width => '10%', sort => 'html'},
      {key => 'hs_id',  title => 'Homologue stable id', align => 'left', width => '20%', sort => 'html'},
      {key => 'gene',   title => 'Homologue gene name', align => 'left', width => '20%', sort => 'html'},
      {key => 'query',  title => 'Query identity', align => 'left', width => '10%', sort => 'html'},
      {key => 'target', title => 'Target identity', align => 'left', width => '10%', sort => 'html'},
    ];

  $html .= $self->new_table($columns, \@rows)->render;

  return $html;
}


1;