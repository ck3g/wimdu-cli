require "spec_helper"

RSpec.describe "Wimdu CLI" do
  let(:exe) { File.expand_path('../../bin/wimdu', __FILE__) }

  describe "list" do
    let(:cmd) { "#{exe} list" }

    context 'when offers already exist' do
      let!(:property) do
        Wimdu::Property.create slug: 'ABC1DEF2',
                               title: 'Amazing Room at Wimdu Office'
      end

      it "allows to list available offers" do
        pending 'Cant see output from feature specs only'
        CliProcess.new(cmd).tap do |p|
          expect(p).to have_output("Found 1 offer.")
          expect(p).to have_output("ABC1DEF2: Amazing Room at Wimdu Office")
        end
      end
    end

    context 'when offers not exist' do
      it 'display "No offers found." message' do
        pending 'Cant see output from feature specs only'
        Wimdu::Property.destroy
        expect { CliProcess.new(cmd) }.to output("No offers found.").to_stdout
      end
    end
  end

  describe "new" do
    let(:cmd) { "#{exe} new" }
    let(:process) { CliProcess.new(cmd) }

    it "allows for entering data" do
      expect(process).to have_output("Starting with new property")
      expect(process).to have_output("Title: ")
      process.type "My Title"
      expect(process).to have_output("Address: ")

      # FIXME: Please extend!

      process.kill
      process.wait
    end
  end

  describe "continue" do
    xit "allows for resuming data entry" do
      code = nil

      CliProcess.new("#{exe} new").tap do |p|
        expect(p).to have_output("Title: ")
        p.type("My Title")
        code = p.output[/Starting with new property ([A-Z1-9]+)\./, 1]

        p.kill("INT")
        p.wait
      end

      CliProcess.new("#{exe} continue #{code}").tap do |p|
        expect(p).to have_output("Continuing with property #{code}")
        # FIXME: Please extend!
      end
    end
  end

  describe "passing invalid args" do
    let(:cmd) { "#{exe} invalid-argument" }

    it "displays warning message" do
      CliProcess.new(cmd).tap do |p|
        expect(p).to have_output("Invalid args.")
      end
    end
  end
end
