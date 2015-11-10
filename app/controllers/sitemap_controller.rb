class SitemapController < Spree::BaseController
  layout false

  def index
    @public_dir = root_url

    respond_to do |format|
      format.html
      format.text

      format.xml do
        render layout: false, xml: _build_xml(@public_dir)
      end
    end
  end

  private

  def _build_xml(public_dir)
    String.new.tap do |output|
      xml = Builder::XmlMarkup.new(:target => output, :indent => 2)
      xml.instruct!  :xml, :version => "1.0", :encoding => "UTF-8"
      xml.urlset( :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" ) {
        xml.url {
          xml.loc         public_dir
          xml.lastmod     Date.today
          xml.changefreq  'weekly'
          xml.priority    '1.0'
        }

        Spree::Taxonomy.all.each do |taxonomy|
          taxonomy.taxons.each do |taxon|
            v = _build_taxon_hash(taxon)
            xml.url {
              xml.loc         public_dir + v['link']
              xml.lastmod     v['updated'].xmlschema        #change timestamp of last modified
              xml.changefreq  'weekly'
              xml.priority    '0.9'
            }
          end
        end

        Spree::Product.active.where(deleted_at: nil).each do |product|
          v = _build_product_hash(product)
          xml.url {
            xml.loc         public_dir + v['link']
            xml.lastmod     v['updated'].xmlschema        #change timestamp of last modified
            xml.changefreq  'weekly'
            xml.priority    '0.7'
          }
        end

      }
    end
  end

  def _build_taxon_hash(taxon)
    tinfo             = {}
    tinfo['name']     = taxon.name
    tinfo['depth']    = taxon.permalink.split('/').size
    tinfo['link']     = 't/' + taxon.permalink
    tinfo['updated']  = taxon.updated_at
    tinfo
  end

  def _build_product_hash(product)
    pinfo             = {}
    pinfo['name']     = product.name
    pinfo['link']     = 'products/' + product.permalink # primary
    pinfo['updated']  = product.updated_at
    pinfo
  end

end
