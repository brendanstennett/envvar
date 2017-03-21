require 'spec_helper'

describe Envvar do
  it 'has a version number' do
    expect(Envvar::VERSION).not_to be nil
  end

  describe 'loading a file' do
    
    before(:each) do
      ENV.delete('REQUIRED_1')
      ENV.delete('REQUIRED_2')
      ENV.delete('FOO')
      ENV.delete('BAZ')
      ENV.delete('BAT')
    end

    let(:path) { File.expand_path('../resources/sample.yml', __FILE__) }

    context 'required' do
      it 'should complain if all reqiored are not present' do
        ENV['REQUIRED_1'] = 'here'

        expect { Envvar.load(path) }.to raise_error(Envvar::EnvironmentError)
      end

      it 'should load properly if all required are present' do
        ENV['REQUIRED_1'] = 'here'
        ENV['REQUIRED_2'] = 'also here'

        Envvar.load(path)
      end
    end

    context 'required set' do
      before(:each) do
        ENV['REQUIRED_1'] = 'here'
        ENV['REQUIRED_2'] = 'also here'
      end

      context 'defaults' do
        it 'should set defaults' do
           Envvar.load(path)

           expect(ENV['FOO']).to eq('bar')
           expect(ENV['BAZ']).to eq('qux')
        end
      end

      context 'environment' do
        it 'should override defaults' do
          Envvar.load(path, :env1)

          expect(ENV['FOO']).to eq('bat')
        end
        it 'should set others' do
          Envvar.load(path, :env1)

          expect(ENV['BAT']).to eq('nat')
        end 
        it 'should load a differnet environment if specified' do
          Envvar.load(path, :env2)

          expect(ENV['FOO']).to eq('baf')
        end
      end
    end
  end
end
